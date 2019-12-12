from django.shortcuts import render, redirect
from django.http import JsonResponse
import json
from .models import Search, Scrapper, Searcher, SearchManager
from knowledge_search import parameters

# Create your views here.

def index(request):
    return render(request,'acceuil.html')

def search(request):
    word = request.GET['word']
    lang = request.GET['lang']
    source = request.GET['source']
    #Check request source as search results are not being returned to home page directly.
    if source == parameters.HOME_PAGE:
        context = {'search_word': word, 'lang': lang}
        return render(request, 'results.html', context) #render result page
    #Prepare and render search results
    manager = SearchManager(word, lang)
    if not manager.has_results():
        manager.executeSearch()
    return JsonResponse(list(manager.get_results()), safe=False)
