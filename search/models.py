from django.db import models, connection
import requests
import re
from bs4 import BeautifulSoup
from googleapiclient.discovery import build
import json
from knowledge_search import parameters

class BlockedSite(models.Model):
    url = models.CharField(name="url", max_length=255)
    
    def __str__(self):
        return self.url




class Search(models.Model):
    search_term = models.CharField(name="search_term", max_length=255)
    lang = models.CharField(name="lang", max_length=10)
    frequency = models.IntegerField(name="frequency")
        
    def __str__(self):
        return self.search_term



class Result(models.Model):
    search_word = models.ForeignKey(Search, related_name="search_word", on_delete=models.CASCADE)
    title = models.CharField(name="title", max_length=255)
    url = models.CharField(name="url", max_length=255)
    snippet = models.CharField(name="snippet", max_length=255)
    nb_match = models.IntegerField(name="nb_match")
        
    def __str__(self):
        return self.title
    
    def toJson(self):
        json_form = {}
        json_form['title'] = self.title
        json_form['url'] = self.url
        json_form['snippet'] = self.snippet
        return json_form



class Searcher:
    def __init__(self):
        self.word = None
        self.lang = None
        self.__start_index = 1
    
    def fit(self, word, lang):
        self.word = word
        self.lang = lang
        self.__start_index = 0
        
    def get_page_count(self):
        return self.__start_index
    
    def get_next_page(self):
        if self.__start_index != 0:
            self.__start_index += 10
        else:
            self.__start_index = 1
        return self.__google_search()
    
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
    
    def __google_search(self):
        engine = build('customsearch', 'v1', developerKey=parameters.API_KEY).cse()
        results = engine.list(q=self.word, cx=parameters.CX, lr=self.lang,
                              start=self.__start_index, alt="json").execute()
        if 'items' in results.keys():
            return results['items']
        else:
            return []



class Scrapper:
    def fit(self, term):
        self.__term = term
        self.__count = -1
    
    def handle(self, url):
        self.__analyzeContent(url)
        if self.__count > parameters.THRESHOLD:
            return True
        else:
            return False
        return True
    
    def __analyzeContent(self, url):
        try:
            page = requests.get(url)
            text = re.sub('<style>+?<style>','',page.text)
            text = re.sub('<script>+?<script>','',text)
            text = re.sub('<[^<]+?>','',text)
            self.__count = text.lower().count(self.__term)
        except Exception as exp:
            self.__count = -1
        
    def getCount(self):
        return self.__count



class SearchManager:
    def __init__(self, word, lang):
        self.word = word.lower()
        self.lang = lang
        self.searcher = Searcher()
        self.searcher.fit(self.word, self.lang)
        self.search_data = []
        self.results = []
        search = Search.objects.all().filter(search_term=self.word, lang=self.lang)
        if len(search) < 1:
            self.search = Search()
            self.search.search_term = self.word
            self.search.lang = self.lang
            self.search.frequency =1
            self.search.save()
        else:
            self.search = search[0]
            self.search.frequency +=1
            self.search.save()
            tmp = Result.objects.all().filter(search_word=self.search)
            for result in tmp:
                self.results.append(result)
        cursor = connection.cursor()
        cursor.execute('select url from search_blockedsite')
        self.blocked_sites = []
        for result in cursor.fetchall():
            self.blocked_sites +=list(result)
    
    def has_results(self):
        return len(self.results)>0
    
    def executeSearch(self):
        while len(self.results)<10 and self.searcher.get_page_count()<50:
            self.__search()
            self.__scrape()
            
    def get_results(self):
        json_results = []
        for result in self.results:
            json_results.append(result.toJson())
        
        return json_results
    
    def __search(self):
        self.search_data = self.searcher.get_next_page()
        
    def __scrape(self):
        scrapper = Scrapper()
        scrapper.fit(self.search.search_term)
        cursor = connection.cursor()
        for result in self.search_data:
            query = "select * from search_blockedsite where url like '%"+result['link']+"%'"
            blocked = cursor.execute(query) > 0
            query = "select * from search_result where url='"+result['link']+"'"
            saved = cursor.execute(query) > 0
            if not blocked and not saved:
                if scrapper.handle(result['link']):
                    item = Result()
                    item.search_word = self.search
                    item.title = result['title']
                    item.url = result['link']
                    item.snippet = result['snippet']
                    item.nb_match = scrapper.getCount()
                    item.save()
                    self.results.append(item)
                    