from django.shortcuts import render
from django.http import HttpRequest, HttpResponse

def result_page(request):
    return HttpResponse("A Result")
    