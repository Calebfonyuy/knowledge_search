"""knowledge_search URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/2.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path
from search import views as sviews
from result import views as rviews

urlpatterns = [
    path('', sviews.index, name="index"),
    path('search', sviews.search, name="search"), #Search url
    path('words', rviews.word_proposal, name="word_proposal"), #Word request url
    path('next_page', sviews.paginate, name="result_page"), #Pagination requests
    path('admin/', admin.site.urls), #Site administration
]
