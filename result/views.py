from django.shortcuts import render
from django.http import HttpResponse, JsonResponse
from django.db import connection

def result_page(request):
    return HttpResponse("A Result")


def word_proposal(request):
    cursor = connection.cursor()
    cursor.execute("select search_term from search_search where search_term like '%"+request.GET['word']+"%'")
    results = cursor.fetchall()
    response = []
    for result in results:
        response +=list(result)
    return JsonResponse(response, safe=False)