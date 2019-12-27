from django.shortcuts import render, redirect
from .models import Search, Scrapper, Searcher, SearchManager
from knowledge_search import parameters
from django.http import JsonResponse, HttpResponse
import threading
import json

#Application Entry point. It simply returns the home page.
def index(request):
    return render(request,'acceuil.html')

#Most frequently searched words
def frequent(request):
    searches = Search.objects.all().order_by('-frequency')[0:9]
    results = list()
    for search in searches:
        results.append(search.to_json());
    return JsonResponse(results, safe=False)

#This function manages incoming searches
def search(request):
    #Get all search parameters
    word = request.GET['word']
    lang = request.GET['lang']
    source = request.GET['source']
    #Check request source as search results are not being returned to home page directly.
    if source == parameters.HOME_PAGE:
        context = {'search_term': word, 'lang': lang}
        return render(request, 'results.html', context) #render result page
    #Prepare and render search results
    manager = SearchManager(word, lang)
    if manager.result_size()<10:
        manager.executeSearch() #Search for new results for the search term
    else:
        if not manager.search.extended_search: #Exhaust the possible number of searches available for a free cgse search
            thread = threading.Thread(manager.execute_extended_search()) # Create a thread to run in background on server
            thread.start()
    return JsonResponse(list(manager.get_results()), safe=False) #Return results as JSON object

#Handling of pagination requests
def paginate(request):
    word = request.GET['word']
    lang = request.GET['lang']
    size = request.GET['size']#Get the page index
    manager = SearchManager(word, lang)
    result_size = manager.result_size()
    if result_size > int(size) and (result_size- int(size))>=10:
        return JsonResponse(list(manager.get_results_with_offset(size)),safe=False)#Return JSON object of results
    if not manager.search.extended_search:
        manager.execute_extended_search()
        return JsonResponse(list(manager.get_results_with_offset(size)),safe=False)#Return JSON object of results
    else:
        return JsonResponse(list(manager.unsaved_results()),safe=False) # Return every other unsaved result