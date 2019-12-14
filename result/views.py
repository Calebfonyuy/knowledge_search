from django.shortcuts import render
from django.http import HttpResponse, JsonResponse
from django.db import connection

#Not used
def result_page(request):
    return HttpResponse("A Result")

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
