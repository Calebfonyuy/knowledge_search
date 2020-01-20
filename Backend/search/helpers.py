from django.db import models, connection
from googleapiclient.discovery import build
from knowledge_search import parameters
from concurrent import futures
from bs4 import BeautifulSoup
from .models import Search, Result, BlockedSite
from .ontologie import get_complete_content
import requests
import html2text
import json
import re


def create_search(request, flag=True):
    #Get all search parameters
    word = request.GET['word']
    lang = request.GET['lang']
    page = int(request.GET['page'])
    search = None
    searches = Search.objects.all().filter(search_term=word, lang=lang)
    if len(searches)>0:
        search = searches[0]
        search.frequency +=1
        search.save()
    else:
        search = Search() 
        search.search_term = word
        search.lang = lang
        search.frequency =1
        search.extended_search = 0;
        search.save()
    if page > 1:
        page = page*10 +1
    search.perform_google_search(page, flag)
    return search
    
