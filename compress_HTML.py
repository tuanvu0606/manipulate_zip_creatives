import htmlmin
from html.parser import HTMLParser

f = open("base.html", "r")

print(f.read())

html = str(f.read())

print (html)

#print(f)

# html = """
# <!DOCTYPE html>
# <html lang="en">
# <head>
#   <title>Bootstrap Case</title>
#   <meta charset="utf-8">
#   <meta name="viewport" content="width=device-width, initial-scale=1">
#   <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
#   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
#   <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
# </head>
# <body> 
# <div class="container">
#   <h2>Well</h2>
#   <div class="well">Basic Well</div>
# </div>
# </body>
# </html>
#"""

minified = htmlmin.minify(base.html, remove_empty_space=True)
print(minified)