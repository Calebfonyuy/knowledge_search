from django.contrib import admin
from .models import BlockedSite, Search, Result

# Register your models here.
#Create possibility of adding results directly to search on creation
class ResultInline(admin.StackedInline):
    model = Result
    extra = 2

class SearchAdmin(admin.ModelAdmin):
    inlines = [ResultInline]
    
class ResultAdmin(admin.ModelAdmin):
    list_display = ('search_word','url','title','snippet','nb_match')
    list_filter = ['title']
    search_fields = ['title', 'url']
    
#Register models for management by administrator
#These models become visible on the administrator interface for creation
#modification and deletion
admin.site.register(BlockedSite)

admin.site.register(Search, SearchAdmin)

admin.site.register(Result)