# -*- coding: utf-8 -*-
import cssutils
import sys

#print (str(sys.argv[1]))

# Parse the stylesheet, replace color
parser = cssutils.parseFile('style.css')
for rule in parser.cssRules:
    try:
        if rule.selectorText == '#ab':
            #rule.style.backgroundColor = str(sys.argv[1])  # Replace background
            rule.style.color = str(sys.argv[1])  # Replace background
            rule.style.top = str(sys.argv[2])  # Replace top_to_text_distance         
            rule.style.width = str(sys.argv[3])  # Replace width of text
    except AttributeError as e:
        pass  # Ignore error if the rule does not have background

# Write to a new file
with open('style_new.css', 'wb') as f:
    f.write(parser.cssText)