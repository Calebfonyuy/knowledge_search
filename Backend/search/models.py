from django.db import models, connection
from googleapiclient.discovery import build
from knowledge_search import parameters
from concurrent import futures
from bs4 import BeautifulSoup
import search.ontologie as ontologie
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
    
    def perform_google_search(self, start_index, flag):
        self.__last_search_index = start_index
        engine = build('customsearch', 'v1', developerKey=parameters.API_KEY).cse()
        results = engine.list(q=self.search_term, cx=parameters.CX, lr=self.lang,
                              start=start_index, alt="json").execute()
        if 'items' in results.keys():
            self.results = results['items']
            if flag:
                self.__filter_results()
        else:
            raise Exception("Search Limit attained")
    
    def clear_results(self):
        try:
            self.results = []
        except:
            pass

    def get_raw_results(self):
        try:
            raw_results = []
            for result in self.results:
                item = dict()
                item['title'] = result['title']
                item['url'] = result['link']
                item['snippet'] = result['snippet']
                raw_results.append(item)
        except:
            self.perform_google_search(1)
        return raw_results

    def get_scrapped_results(self):
        self.scraped_results = list()
        cursor = connection.cursor()
        for result in self.results:
            query = "select * from search_blockedsite where locate(url, '"+result['link']+"')>0 or locate('"+result['link']+"',url)>0"
            blocked = cursor.execute(query) > 0 #Verify that site is not from a blocked domain
            if blocked:
                continue
            snippet = result['snippet']
            try:
                page = requests.get(result['link'], verify=False, timeout=3)
                ontologie.get_complete_content(page.text, result['snippet'].replace('\n',''))
            except:
                pass
            item = Result()
            item.search_word = self
            item.title = result['title']
            item.url = result['link']
            item.snippet = snippet
            self.scraped_results.append(item.toJson())
        return self.scraped_results


    
    def get_filtered_results(self):
        return self.clean_results

    def __filter_results(self):
        self.clean_results = []
        pool = futures.ThreadPoolExecutor(max_workers=12)
        pool.map(self.__scrape_site, self.results)

    def __scrape_site(self, result):
        scrapper = html2text.HTML2Text()
        scrapper.ignore_images = True
        scrapper.ignore_emphasis = True
        scrapper.ignore_links = True
        scrapper.ignore_tables = True
        try:
            cursor = connection.cursor()
            query = "select * from search_blockedsite where locate(url, '"+result['link']+"')>0 or locate('"+result['link']+"',url)>0"
            blocked = cursor.execute(query) > 0 #Verify that site is not from a blocked domain
            if blocked:
                return
            page = requests.get(result['link']) #Request html page
            text = ontologie.clean_text(page.text) #clear tags and new lines
            count = text.lower().count(self.__term) #count number of occurences of search term on page
            if count > parameters.THRESHOLD: #Call scrapping method to determine if the page is valid
                item = Result() #Create and save new result item for valid result
                item.search_word = self
                item.title = result['title']
                item.url = result['link']
                item.snippet = ontologie.get_complete_content(page.text, result['snippet'])
                item.nb_match = count
                self.clean_results.append(item.toJson())
        except Exception as exp:
            raise Exception("Error Loading url")



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
        json_form = dict()
        json_form['title'] = self.title
        json_form['url'] = self.url
        json_form['snippet'] = self.snippet
        return json_form
