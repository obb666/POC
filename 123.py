url = 'https://static.googleusercontent.com/media/www.google.com/en//googleblogs/pdfs/google_predicting_the_present.pdf'
 
# downloading with urllib
 
# import the urllib package
import urllib
 
# Copy a network object to a local file
urllib.urlretrieve(url, "tutorial.pdf")
 
 
# downloading with requests
 
# import the requests library
import requests
 
# download the file contents in binary format
r = requests.get(url)
 
# open method to open a file on your system and write the contents
with open("tutorial1.pdf", "wb") as code:
    code.write(r.content)