#!/usr/bin/python

# This is a simple script to convert the generated html api docs so that
# they have a consistent look and feel with the rest of the dart website.
# To run, type "python styleDocs.py" from this directory, and have the files
# that need to be converted in the api directory.

import os


# Fix up the navigation page.
f = open('api/index.html') 
navFile = open('../_includes/documentationNav.html', 'w')
# cycle past the initial html mumbo jumbo to get the content.
line = f.readline()
while (not ('<header>' in line)) and (line != ''):
  line = f.readline()
if (line != ''):
  line = f.readline()
  navFile.write('<section id="classes-nav">')
  while not ('<footer>' in line)  and (line != ''):
    #if '<ul>' in line: 
    #  index = line.find('#')
    #  while index != -1:
    #    otherIndex = line.find('\'', index + 1)
    #    line = line[:index] + line[otherIndex:]
    #    index = line.find('#')
    navFile.write(line)
    line = f.readline()
  navFile.write('</section>')
    
  f.close()
  navFile.close()


#Now fix all the other files.
files = os.listdir("api")

for file in files:
  if file.endswith(".html"):
    f = open('api/'+file, 'r')
    tempfile = open('tmpfile.foo', 'w')
    # cycle past the initial html mumbo jumbo to get the content.
    line = f.readline()
    page_title = ''
    while (not ('<header>' in line)) and (line != ''):
      if '<title>' in line:
        page_title = line[len('<title>'): len(line) - len('</title>')- 1]
      line = f.readline()
    if (line != ''):
      if file != 'index.html':
        tempfile.write('''---
layout: docsLayout
title: "''' + page_title + '''" 
---
''')
      else:
        tempfile.write('''---
layout: default
title: "''' + page_title + '''" 
---
''')


      line = f.readline()
      while not ('<footer>' in line ) and (line != ''): 
        if '<a name' in line: 
          index = line.find('<a name')
          otherIndex = line.find('>', index + 1)
          line = line[:index] + line[otherIndex + 1:]
          line.replace('''</a>''', '', 1)
        tempfile.write(line)
        line = f.readline()

      f.close()
      tempfile.close()

      os.popen('rm api/' + file)
      os.popen('mv ' + 'tmpfile.foo api/' + file)
