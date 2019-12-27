from django.db import models, connection
from googleapiclient.discovery import build
from knowledge_search import parameters
from concurrent import futures
from bs4 import BeautifulSoup
import requests
import html2text
import json
import re

#Model for representation of blocked or restricted domains
class BlockedSite(models.Model):
    url = models.CharField(name="url", max_length=255)
    
    def __str__(self):
        return self.url



# Model that represents each search by the a user
class Search(models.Model):
    search_term = models.CharField(name="search_term", max_length=255)#item searched by user
    lang = models.CharField(name="lang", max_length=10)#Language
    frequency = models.IntegerField(name="frequency")#Number of times the particular term has been searched
    extended_search = models.IntegerField(name="extended_search")#Check on how whether all possible results have been gotten
        
    def __str__(self):
        return self.search_term
    
    def to_json(self):
        json_form = {}
        json_form['word'] = self.search_term;
        json_form['lang'] = self.lang;
        return json_form;
        


#Class represented each search result.
class Result(models.Model):
    search_word = models.ForeignKey(Search, related_name="search_word", on_delete=models.CASCADE)#Search term
    title = models.CharField(name="title", max_length=255)#Page title
    url = models.CharField(name="url", max_length=255)#Page URL
    snippet = models.CharField(name="snippet", max_length=255)#Extract on content texxt
    nb_match = models.IntegerField(name="nb_match")#Number of occurences of search term on page
        
    def __str__(self):
        return self.title
    
    #Create JSON object out of result object
    def toJson(self):
        json_form = {}
        json_form['title'] = self.title
        json_form['url'] = self.url
        json_form['snippet'] = self.snippet
        return json_form


#Class in charge of recuperating google custom search results and managing the paging.
class Searcher:
    def __init__(self):
        self.word = None
        self.lang = None
        self.__start_index = 1
    
    #Initializing parameters or reinitialization
    def fit(self, word, lang):
        self.word = word
        self.lang = lang
        self.__start_index = 0
    
    def init_page_count(self):
        self.__start_index = 0
        
    def get_page_count(self):
        return self.__start_index
    
    def get_next_page(self):
        if self.__start_index != 0:
            self.__start_index += 10
        else:
            self.__start_index = 1
        return self.__google_search()
    
    #Collect multiple pages
    def get_next_pages(self, count):
        result_list = []
        
        if self.__start_index != 0:
            self.__start_index += 10
        else:
            self.__start_index = 1
            
        for i in range(count):
            result_list += self.__google_search()
            self.__start_index += 10
            
        self.__start_index -= 20
        return result_list
    
    #Perform google search
    def __google_search(self):
        engine = build('customsearch', 'v1', developerKey=parameters.API_KEY).cse()
        results = engine.list(q=self.word, cx=parameters.CX, lr=self.lang,
                              start=self.__start_index, alt="json").execute()
        if 'items' in results.keys():
            return results['items']
        else:
            return []


#Class in charge of web scrapping
class Scrapper:
    #Initialize all class parameters
    def fit(self, term):
        self.__term = term
        self.__count = -1
        self.__scrapper = html2text.HTML2Text()
        self.__scrapper.ignore_images = True
        self.__scrapper.ignore_emphasis = True
        self.__scrapper.ignore_links = True
        self.__scrapper.ignore_tables = True
    
    #Perform web scrapping on a certain url and determine whether or not it is valid
    def handle(self, url):
        self.__analyzeContent(url)
        if self.__count > parameters.THRESHOLD:
            return True
        else:
            return False
        return True
    
    #Web scrapping function
    def __analyzeContent(self, url):
        try:
            page = requests.get(url) #Request html page
            text = self.__scrapper.handle(page.text).replace('\n', ' ') #clear tags and new lines
            self.__count = text.lower().count(self.__term) #count number of occurences of search term on page
        except Exception as exp:
            self.__count = -1
        
    def getCount(self):
        return self.__count


#General Managemengment of searches and results
class SearchManager:
    #Initialize class attributes
    def __init__(self, word, lang):
        self.word = word.lower()
        self.lang = lang
        self.searcher = Searcher()
        self.searcher.fit(self.word, self.lang)
        self.search_data = []
        search = Search.objects.all().filter(search_term=self.word, lang=self.lang) #Find search term in database
        if len(search) < 1: #Create and save new word if word not found
            self.search = Search() 
            self.search.search_term = self.word
            self.search.lang = self.lang
            self.search.frequency =1
            self.search.save()
        else: #Increase search frequency for existing word
            self.search = search[0]
            self.search.frequency +=1
            self.search.save()
        cursor = connection.cursor()
        cursor.execute('select url from search_blockedsite') #Get the list of all blocked domains
        self.blocked_sites = []
        for result in cursor.fetchall():
            self.blocked_sites +=list(result)#Create an easily iterable list
    
    #Find out the number of results exist for a given search term
    def result_size(self):
        cursor = connection.cursor()
        cursor.execute("Select count(*) as total from search_result where search_word_id={}".format(self.search.id))
        return cursor.fetchone()[0]
    
    #Iteratively exectute search until a number of results required is obtained or the max search count exceeded
    def executeSearch(self):
        cursor = connection.cursor()
        cursor.execute("Select count(*) as total from search_result where search_word_id={}".format(self.search.id))
        results = cursor.fetchone()[0]
        while results<10 and self.searcher.get_page_count()<90:
            self.__search() #Get a page of search results
            self.__perform_scrapping() #perform web scrapping on the entire set.
            cursor.execute("Select count(*) as total from search_result where search_word_id={}".format(self.search.id))
            results = cursor.fetchone()[0] #Check out the number of results stored in DB
    
    #Execute a search that goes right through the maximum number of pages.
    def execute_extended_search(self):
        self.search.extended_search = 1 #Update search term to notify that this exhaustive search has been performed
        self.search.save()
        cursor = connection.cursor()
        cursor.execute("Select count(*) as total from search_result where search_word_id={}".format(self.search.id))
        results = cursor.fetchone()[0]
        while results<50 and self.searcher.get_page_count()<90:
            self.__search()
            self.__perform_scrapping()
            cursor.execute("Select count(*) as total from search_result where search_word_id={}".format(self.search.id))
            results = cursor.fetchone()[0]
            
    #Collect and return all results that already exist in the database
    def get_results(self):
        results = Result.objects.all().filter(search_word=self.search).order_by('-nb_match')[0:10]
        json_results = []
        for result in results:#Convert QuerySet to standard list
            json_results.append(result.toJson())
        
        return json_results
    
    #Collect and return all results begining at a certain index(Results are ordered by number of matches)
    def get_results_with_offset(self, offset):
        results = Result.objects.all().filter(search_word=self.search).order_by('-nb_match')[offset:10]
        json_results = []
        for result in results:#Convert to standard list
            json_results.append(result.toJson())
        
        return json_results
    
    #Fetch a page of cgse results
    def __search(self):
        self.search_data = self.searcher.get_next_page()
        
    #Perform scrapping on result item and decide it's fate
    def __scrape(self, result):
        scrapper = Scrapper()
        scrapper.fit(self.search.search_term)
        cursor = connection.cursor()
        query = "select * from search_blockedsite where locate(url, '"+result['link']+"')>0 or locate('"+result['link']+"',url)>0"
        blocked = cursor.execute(query) > 0 #Verify that site is not from a blocked domain
        query = "select * from search_result where url='"+result['link']+"'"
        saved = cursor.execute(query) > 0 #Verify that result item is not yet saved in database
        if not blocked and not saved:
            if scrapper.handle(result['link']): #Call scrapping method to determine if the page is valid
                item = Result() #Create and save new result item for valid result
                item.search_word = self.search
                item.title = result['title']
                item.url = result['link']
                item.snippet = result['snippet'].replace('\n',' ')
                item.nb_match = scrapper.getCount()
                item.save()
    
    #Create several threads to handle simultaneous scrapping on entire result set
    def __perform_scrapping(self):
        with futures.ThreadPoolExecutor(max_workers=12) as executor: #Create thread manager
            executor.map(self.__scrape, self.search_data) #Call threads with data
    
    #Retrieve list of all results that have not been saved in database
    def unsaved_results(self):
        self.searcher.init_page_count()
        search_data = self.searcher.get_next_pages(10)
        unsaved_links = []
        cursor = connection.cursor()
        for result in search_data:
            query = "select * from search_result where url='"+result['link']+"'"
            saved = cursor.execute(query) > 0 #Check that the item is not yet saved
            if not saved:
                item = Result()
                item.search_word = self.search
                item.title = result['title']
                item.url = result['link']
                item.snippet = result['snippet']
                item.nb_match = -1
                unsaved_links.append(item)
                
        return unsaved_links