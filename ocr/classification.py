import re
from difflib import SequenceMatcher
import json

product_mapping = {
    "Joghurt": ["Alpro", "Jog", "Joghurt"],
    "Nudeln": ["Deliz.Pas", "Pasta", "Deliz", "Pas", "Simply"],
    "Bohnen": ["Kidney-Bohnen", "Kidney", "Bohnen"],
    "Haferjoghurt": ["Haferghurt"],
    "Frischkäse": ["Exquisa"],
    "Kapern": ["Kapern", "Dittm"],
    "Haferdrink": ["Haferd"],
    "Äpfel": ["Äpfel", "Lose"],
    "Bananen": ["Bananen"],
    "Zitronen": ["Zitronen", "SL"],
    "Karotten": ["Karotten"],
    "Tomaten": ["Pflaumentomaten"],
    "Salat": ["Salate", "Bunte"]
}


def string_similarity(a, b):
    return SequenceMatcher(None, a, b).ratio()


def get_products(text):
    products_found = []
    for line in text.split("\n"):
        matches = []
        #print(f"Scanning: {line}")
        for product in product_mapping:
            for keyword in product_mapping[product]:
                x = re.findall(keyword, line)
                if len(x) == 0:
                    for word in line.split(" "):
                        if len(word) > 3 and len(keyword)-2 < len(word) < len(keyword)+2:
                            sim = string_similarity(word, keyword)
                            if sim > 0.8:
                                matches.append(product)
                else:
                    matches.append(product)
        products_found.append(matches)
    #print(products_found)
    result = []
    for product_group in products_found:
        if len(product_group) > 0:
            if len(product_group) != product_group.count(product_group[0]):
                print("Error: mismatching product groups")
            else:
                result.append(product_group[0])

    final_result = []
    for item in result:
        for pair in final_result:
            if item not in pair:
                final_result.append([item, 1])
            else:
                final_result[final_result.index(item)][1] += 1

    print(final_result)
