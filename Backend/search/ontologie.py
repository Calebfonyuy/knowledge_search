from bs4 import BeautifulSoup
import requests as req
import re
from html2text import HTML2Text as h
import ast


def clean_text(request_text):
    scrapper = h()
    scrapper.ignore_images = True
    scrapper.ignore_emphasis = True
    scrapper.ignore_links = True
    scrapper.ignore_tables = True
    clean_txt = scrapper.handle(request_text).replace('#','').replace('\"','').replace('\*','')
    clean_txt = clean_txt.replace('\n',' ')
    
    return clean_txt


def get_complete_content(page_text, target_text):
    # Create soup object
    soup = BeautifulSoup(page_text, 'html.parser')
    
    clean_txt = clean_text(page_text)
    text_portions = target_text.split('...')
    
    text = text_portions[0]
    for simple in text_portions:
        if len(text)< len(simple):
            text = simple
    
    texts = text.split(' ')
    found = False
    found_item = None
    max_index = len(texts)

    index = 0
    result_text = ""
    while index<max_index-1 and not found:
        word = texts[index] + " "+ texts[index+1]
        results = soup.find_all(string=re.compile(word))
        if len(results)>0:
            for result in results:
                line = clean_text(str(result.parent))
                line = line.replace('\n', ' ')
                position = line.find(text[0:20])
                if position > -1:
                    if len(line) > len(result_text):
                        result_text = line
                    found = True
                    break
        index+=1
        
    if len(result_text)>0:
        return result_text
    else:
        return clean_text(target_text)
