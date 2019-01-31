import tinycss
from html.parser import HTMLParser

stylesheet = tinycss.make_parser().parse_stylesheet('div.error, #root > section:first-letter { color: red }')
print (stylesheet)
class MyHTMLParser(HTMLParser):
    def handle_starttag(self, tag, attrs):
        print("Encountered a start tag:", tag)

    def handle_endtag(self, tag):
        print("Encountered an end tag :", tag)

    def handle_data(self, data):
        print("Encountered some data  :", data)

# parser = MyHTMLParser()
# parser.feed('https://s3-ap-southeast-1.amazonaws.com/yoose-tmp/Banner_for_v4/TheCoffeeHouse_1/TheCoffeeHouse_creative_4.html')

print (stylesheet.rules)