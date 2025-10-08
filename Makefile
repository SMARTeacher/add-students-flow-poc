.PHONY: start

start:
	npm i
	@./setup-env.sh
	npm run start