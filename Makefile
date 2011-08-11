all: o2 build prod

build:
	rm -rf ./build && cd ./build/site && jekyll --pygments src--no-server --no-auto && cd ../.. && cp ./src/appengine/* build/

prod: build
	cd ./build && appcfg.py update .

server:
	@open http://localhost:8080/ && cd ./src/site && jekyll && cd ../..

optimize:
	@find . -iname *.png | xargs -L 1 optipng -o7

o2:
	@find . -iname *.png | xargs -L 1 optipng -o2
