CURRENT_BRANCH=$(shell git branch --no-color | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
LAST_COMMIT=$(shell git log -n 1 --pretty=format:"%H")
PWD=$(shell pwd)
LOCAL=http://localhost:8081/
XDGOPEN=$(shell type xdg-open 2>/dev/null)
ifeq ($(XDGOPEN),)
OPEN=open $(LOCAL)
else
OPEN=xdg-open $(LOCAL)
endif

clean:
	rm -rf ./build

build: copy remove_node_modules add_version add_release

pubget:
	find . -name pubspec.yaml -exec bash -c ' cd $$(dirname {});pwd;pub get' \;

build_apps:
	cd ./src/site/tools/download-archive && pub get && pub build -o out

copy: clean
	cd ./src/site && bundle exec jekyll build && cd ../.. && cp -R ./src/appengine/* build/

remove_node_modules: copy
	rm -rf build/static/events/2015/summit/node_modules

add_version:
	ruby -p -i -e '$$_.gsub!(/CHANGEME/, "$(CURRENT_BRANCH)")' ./build/app.yaml

add_release:
	ruby -p -i -e '$$_.gsub!(/CURRENT_BRANCH/, "$(CURRENT_BRANCH)")' ./build/static/release.txt
	ruby -p -i -e '$$_.gsub!(/LAST_COMMIT/, "$(LAST_COMMIT)")' ./build/static/release.txt

deploy: build
	cd ./build && appcfg.py --oauth2 update .
	@echo "Visit https://$(CURRENT_BRANCH)-dot-dart-lang.appspot.com"

server:
	ruby -e 'sleep 3; 1.upto(30) { break if system("curl -I -s $(LOCAL)"); print "."; sleep 1 }; exec "$(OPEN)"' &
	cd ./src/site && bundle exec jekyll serve -w --port=8081 --trace

optimize:
	@find . -iname *.png | xargs -L 1 optipng -o7

o2:
	@find . -iname *.png | xargs -L 1 optipng -o2

dartisansplaylist:
	dart scripts/gen_dartisans_playlist.dart

darttips:
	cd scripts && dart gen_dart_tips.dart

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
	cp -R $(BOOK_XML_DIR)/figs/web/*.gif $(BOOK_XML_DIR)/figs/web/*.png src/site/docs/dart-up-and-running/contents/figs/web
endif

book: copy-book-images convert-book-html-to-jekyll

compile-sample-apps: observables-samples

observables-samples:
	cd src/site/web-ui/observables/code && pub get && dart build.dart

sanity-test:
	bundle exec ruby src/tests/site/sanity.rb

sanity-test-live:
	bundle exec ruby src/tests/site/sanity.rb https://www.dartlang.org/
