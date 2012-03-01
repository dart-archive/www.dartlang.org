clean:
	rm -rf ./build

build:
	rm -rf ./build && cd ./src/site && jekyll --no-server --no-auto && cd ../.. && cp -R ./src/appengine/* build/

add_version:
	/usr/local/bin/ruby -p -i -e '$$_.gsub!(/CHANGEME/, Time.now.strftime("%Y-%m-%dt%H-%M"))' ./build/app.yaml

deploy: build add_version
	cd ./build && appcfg.py update .

server:
	@open http://localhost:8080/ && cd ./src/site && jekyll && cd ../..

optimize:
	@find . -iname *.png | xargs -L 1 optipng -o7

o2:
	@find . -iname *.png | xargs -L 1 optipng -o2
