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
