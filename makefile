#!/usr/bin/make -f

include makefile.config
-include makefile.config.local

.PHONY: build debug default logs remove run shell start status stop

default: build

build:
	docker build --force-rm=true --tag=$(registry)$(namespace)/$(image):$(tag) $(buildargs) $(ARGS) .

debug:
	docker run \
		--hostname=$(name) \
		--interactive=true \
		--name=$(name) \
		--tty=true \
		$(runargs) \
		$(registry)$(namespace)/$(image):$(tag) \
		$(ARGS)

grafana:
	docker run \
		--detach=true \
		--hostname=$(name)-grafana \
		--name=$(name)-grafana \
		--rm=true \
		$(grafanarunargs) \
		grafana/grafana:$(grafanatag) \
		$(ARGS)

logs:
	docker logs --follow=true $(ARGS) $(name)

remove:
	docker rm --volumes=true $(ARGS) $(name)

run:
	docker run \
		--detach=true \
		--hostname=$(name) \
		--name=$(name) \
		--tty=true \
		$(runargs) \
		$(registry)$(namespace)/$(image):$(tag) \
		$(ARGS)

shell:
	docker exec --interactive=true --tty=true --user=root $(name) /bin/login -f root -p $(ARGS)

start:
	docker start $(ARGS) $(name)

status:
	docker ps $(ARGS) --all=true --filter=name=$(name)

stop:
	docker stop $(ARGS) $(name)

