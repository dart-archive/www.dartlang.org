CURRENT_BRANCH=$(shell git branch --no-color | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
PWD=$(shell pwd)

clean:
	rm -rf ./build

build: copy add_version

compass:
	compass compile src/site/

copy: clean compass
	cd ./src/site && jekyll --no-server --no-auto && cd ../.. && cp -R ./src/appengine/* build/

add_version:
	ruby -p -i -e '$$_.gsub!(/CHANGEME/, "$(CURRENT_BRANCH)")' ./build/app.yaml

deploy: build
	cd ./build && appcfg.py update .
	@echo "Visit http://$(CURRENT_BRANCH).dart-lang.appspot.com"

server:
	@open http://localhost:8080/ && cd ./src/site && jekyll

optimize:
	@find . -iname *.png | xargs -L 1 optipng -o7

o2:
	@find . -iname *.png | xargs -L 1 optipng -o2

dartisansplaylist:
	dart scripts/gen_dartisans_playlist.dart

convert-docbook-to-html:
ifndef BOOK_XML_DIR
	@echo "You must specify the location of the .xml files. Example: \n  make book BOOK_XML_DIR=~/Spot/dartbook/SVN \nSkipping docbook-to-html conversion."
else
	cd $(BOOK_XML_DIR) ; \
	xsltproc --xinclude \
	         --stringparam base.dir $(PWD)/_bookhtml/ \
	         --stringparam use.id.as.filename 1 \
	         --stringparam chunk.first.sections 1 \
	         --stringparam chunker.output.encoding UTF-8 \
	         $(PWD)/third_party/docbook-xsl-1.78.0/html/chunk.xsl book.xml
endif

convert-book-html-to-jekyll: convert-docbook-to-html
	dart scripts/convert_book.dart _bookhtml src/site/docs/dart-up-and-running/contents

copy-book-images:
ifndef BOOK_XML_DIR
	@echo "You must specify the location of the .xml files. Example: \n  make book BOOK_XML_DIR=~/Spot/dartbook/SVN \nSkipping copy-book-images."
else
	mkdir -p src/site/docs/dart-up-and-running/contents/figs/web
	cp -R $(BOOK_XML_DIR)/figs/web/*.png src/site/docs/dart-up-and-running/contents/figs/web
endif

book: copy-book-images convert-book-html-to-jekyll
