from .models import Search
from .helpers import create_search
from django.db import connection
from django.http import JsonResponse, HttpResponse

#Application Entry point. It simply returns the home page.
def index(request):
    resp = HttpResponse("Greetings from knowledge_search....")
    return resp


#Most frequently searched words
def frequent(request):
    searches = Search.objects.all().order_by('-frequency')[0:9]
    results = list()
    for search in searches:
        results.append(search.to_json());
    return JsonResponse(results, safe=False)


#This function manages incoming searches requesting filtered results
def filtered_search(request):
    search = create_search(request)
    return JsonResponse(list(search.get_filtered_results()), safe=False) #Return results as JSON object


def raw_search(request):
    search = create_search(request, flag=False)
    return JsonResponse(list(search.get_raw_results()), safe=False) #Return results as JSON object


def scrapped_search(request):
    search = create_search(request, flag=False)
    return JsonResponse(list(search.get_scrapped_results()), safe=False) #Return results as JSON object

def mixed_search(request):
    search = create_search(request)
    result = dict()
    result['raw'] = search.get_raw_results()
    result['filtered'] = search.get_filtered_results()
    return JsonResponse(list(search.get_raw_results()), safe=False)


'''
This function receives an incoming request for word proposals and returns the 
set of words that start with the word sent as a parameter.
'''
def word_proposal(request):
    cursor = connection.cursor()
    word = request.GET['word']
    lang = request.GET['lang']
    cursor.execute("select search_term from search_search where search_term like '"+word+"%' and lang='"+lang+"'")
    results = cursor.fetchall()
    response = []
    for result in results:
        response +=list(result)
    return JsonResponse(response, safe=False) #Return results as a JSON object