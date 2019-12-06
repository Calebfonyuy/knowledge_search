from django.shortcuts import render
from django.http import HttpRequest, HttpResponse
from .models import Search, Scrapper, Searcher, SearchManager

# Create your views here.

def index(request):
    return render(request,'acceuil.html')

def search(request):
    word = request.GET['word']
    lang = request.GET['lang']
    manager = SearchManager(word, lang)
    manager.executeSearch()
    return HttpResponse(manager.results)

def word_proposal(request):
    return HttpResponse(['word1', 'word2', 'word3'])
