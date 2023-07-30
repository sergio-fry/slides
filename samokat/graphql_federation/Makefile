watch:
	touch slides.html
	open slides.html
	../.engine/node_modules/@marp-team/marp-cli/marp-cli.js --engine ../.engine/engine.js -w README.md -o slides.html

build:
	../.engine/node_modules/@marp-team/marp-cli/marp-cli.js --engine ../.engine/engine.js  --allow-local-files README.md -o slides.pptx

pdf:
	../.engine/node_modules/@marp-team/marp-cli/marp-cli.js --engine ../.engine/engine.js  --allow-local-files README.md -o slides.pdf
