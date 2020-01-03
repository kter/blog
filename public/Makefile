serve: _posts _config.yml
	bundle exec jekyll serve

build: _posts _config.yml
	bundle exec jekyll build

deploy: build _site  _config.yml
	$(eval DATE := $(shell date +%Y%m%d%H%M%s))
	docker build -t kter/blog:$(DATE) .
	docker tag kter/blog:$(DATE) kter/blog:latest
	docker push kter/blog:${DATE}
	docker push kter/blog:latest
	kubectl --insecure-skip-tls-verify set image deployments/blog blog=kter/blog:$(DATE)
	kubectl --insecure-skip-tls-verify rollout status deployment/blog

.PHONY: serve build deploy
