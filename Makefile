all: o2 build prod

build:
	cd ./private/jekyll && jekyll --no-server --no-auto && cd ../..

prod: build
	# deploy via App Engine

server:
	@open http://localhost:8080/facts/ && cd ./private/jekyll && jekyll && cd ../..

optimize:
	@find . -iname *.png | xargs -L 1 optipng -o7

o2:
	@find . -iname *.png | xargs -L 1 optipng -o2
