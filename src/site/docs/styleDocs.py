#!/usr/bin/python

# This is a simple script to convert the generated html api docs so that
# they have a consistent look and feel with the rest of the dart website.
# To run, type "python styleDocs.py" from this directory.

import os

files = os.listdir("api")

for file in files:
  if file.endswith(".html"):
    f = open('api/'+file, 'r')
    tempfile = open('tmpfile.foo', 'w')
    # cycle past the initial html mumbo jumbo to get the content.
    line = f.readline()
    page_title = ''
    while (not ('<header>' in line)) or (line == ''):
      if '<title>' in line:
        page_title = line[len('<title>'): len(line) - len('</title>')- 1]
      line = f.readline()
    if (line != ''):
      tempfile.write('''---
layout: default
title: "''' + page_title + '''" 
---
''')
  
      line = f.readline()
      while (line != ''): 
        tempfile.write(line)
        line = f.readline()

      f.close()
      tempfile.close()

      os.popen('rm api/' + file)
      os.popen('mv ' + 'tmpfile.foo api/' + file)
    
