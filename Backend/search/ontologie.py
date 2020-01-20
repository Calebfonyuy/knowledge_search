from bs4 import BeautifulSoup
import requests as req
import re
from html2text import HTML2Text as h
import ast

scrapper = h()
scrapper.ignore_images = True
scrapper.ignore_emphasis = True
scrapper.ignore_links = True
scrapper.ignore_tables = True

def clean_text(request_text):
    clean_txt = scrapper.handle(request_text).replace('\n',' ').replace('#','').replace('\"','').replace('\*','')
    
    return clean_txt


def get_complete_content(page_text, target_text):
    # Create soup object
    soup = BeautifulSoup(page_text, 'html.parser')
    
    last_index = target_text.rfind('...')
    if last_index == len(target_text)-3:
        target_text = target_text[0:last_index]

    text_portions = [target_text]

    # Check if text is made up of several portions then break it into several
    # strings
    clean_txt = clean_text(page_text)
    if clean_txt.find(target_text) < 0:
        text_portions = target_text.split('...')
    
    found_portions = set()
    for text in text_portions:
        texts = text.split(' ')
        found = False
        found_item = None
        max_index = len(texts)

        index = 0

        while index<max_index-1 and not found:
            word = texts[index] + " "+ texts[index+1]
            results = soup.find_all(string=re.compile(word))
            if len(results)>0:
                for result in results:
                    line = clean_text(str(result.parent))
                    if line.find(text) >-1:
                        found = True
                        found_item = line
                        break
            index+=1

        if found:
            found_portions.add(found_item.strip())

    if len(found_portions)>0:
        return found_portions
    else:
        return target_text
