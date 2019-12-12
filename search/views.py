from django.shortcuts import render, redirect
from .models import Search, Scrapper, Searcher, SearchManager
from knowledge_search import parameters
from django.http import JsonResponse
import threading
import json


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
    if manager.result_size()<10:
        manager.executeSearch()
    else:
        if not manager.search.extended_search:
            thread = threading.Thread(manager.execute_extended_search())
            thread.start()
    return JsonResponse(list(manager.get_results()), safe=False)

def paginate(request):
    word = request.GET['word']
    lang = request.GET['lang']
    size = request.GET['size']
    manager = SearchManager(word, lang)
    result_size = manager.result_size()
    if result_size > int(size) and (result_size- int(size))>=10:
        return JsonResponse(list(manager.get_results_with_offset(size)),safe=False)
    if not manager.search.extended_search:
        manager.execute_extended_search()
        return JsonResponse(list(manager.get_results_with_offset(size)),safe=False)
    else:
        return JsonResponse(list(manager.unsaved_results()),safe=False)