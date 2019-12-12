from django.contrib import admin
from .models import BlockedSite, Search, Result

# Register your models here.

class ResultInline(admin.StackedInline):
    model = Result
    extra = 2

class SearchAdmin(admin.ModelAdmin):
    inlines = [ResultInline]
    
class ResultAdmin(admin.ModelAdmin):
    list_display = ('search_word','url','title','snippet','nb_match')
    list_filter = ['title']
    search_fields = ['title', 'url']
    

admin.site.register(BlockedSite)

admin.site.register(Search, SearchAdmin)

admin.site.register(Result)