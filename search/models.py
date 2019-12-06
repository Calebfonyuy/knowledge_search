from django.db import models, connection
import requests
from bs4 import BeautifulSoup
from googleapiclient.discovery import build
from knowledge_search import parameters

class BlockedSite(models.Model):
    url = models.CharField(name="url", max_length=255)
    pass


class Search(models.Model):
    search_term = models.CharField(name="search_term", max_length=255)
    lang = models.CharField(name="lang", max_length=10)
    frequency = models.IntegerField(name="frequency")
    
    def __init__(self, search_term, lang):
        self.search_term = search_term
        self.lang = lang
        self.frequency = 0

class Result(models.Model):
    search_word = models.ForeignKey(Search, related_name="search_word", on_delete=models.CASCADE)
    title = models.CharField(name="title", max_length=255)
    url = models.CharField(name="url", max_length=255)
    snippet = models.CharField(name="snippet", max_length=255)
    nb_match = models.IntegerField(name="nb_match")
    
    def __init__(self, search_word, title, url, snippet, nb_match):
        self.search_word = search_word
        self.title = title
        self.url = url
        self.snippet = snippet
        self.nb_match = nb_match
    
class Searcher:
    def __init__(self):
        self.word = None
        self.lang = None
        self.__start_index = 1
        '''
        result = connection.cursor().execute('SELECT GROUP_CONCAT(url) as sites FROM  knowledge_search_blocked_site').fetchone()
        self.__blocked = result['sites']
        '''
        #self.__blocked = BlockedSite.objects.raw('SELECT GROUP_CONCAT(url) from knowledge_search_blocked_site')
        self.__blocked = ""
        pass
    
    def fit(self, word, lang):
        self.word = word
        self.lang = lang
        self.__start_index = 0
    
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
        results = engine.list(q=self.word, cx=parameters.CX, lr=self.lang, siteSearchFilter='e',
                              start=self.__start_index, siteSearch=self.__blocked, alt="json").execute()
        return results['items']

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
            page_content = requests.get(url)
            soup = BeautifulSoup(page_content, 'html.parser')
            text = "".join(soup.findAll(text=True))
            self.__count = text.count(self.__term)
        except Exception as exp:
            self.__count = -1
        
    def getCount(self):
        return self.__count

class SearchManager:
    def __init__(self, word, lang):
        self.word = word
        self.lang = lang
        self.search = None
        self.results = None
    
    def executeSearch(self):
        self.__search()
        #self.__scrape()
    
    def __search(self):
        #search = Search.objects.all().filter(word=self.word)
        search = []
        if len(search) < 1:
            self.search = Search(self.word, self.lang)
            #self.search.save()
        else:
            self.search = search[0]
        searcher = Searcher()
        searcher.fit(self.word, self.lang)
        self.results = searcher.get_next_page()
        
    def __scrape(self):
        valid_results = []
        scrapper = Scrapper()
        scrapper.fit(search.word)
        for result in self.results:
            if scrapper.handle(result['link']):
                item = Result(search, result['title'], result['link'], result['htmlSnippet'], scrapper.getCount())
                valid_results.append(item)
        
        self.results=valid_results