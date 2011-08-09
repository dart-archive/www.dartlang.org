all: o2 build prod

build:
	cd ./private/site && jekyll --no-server --no-auto && cd ../.. && cp ./private/appengine/* public/

prod: build
	cd ./public && appcfg.py update .

server:
	@open http://localhost:8080/ && cd ./private/site && jekyll && cd ../..

optimize:
	@find . -iname *.png | xargs -L 1 optipng -o7

o2:
	@find . -iname *.png | xargs -L 1 optipng -o2
