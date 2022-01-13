COMPOSE_RUN_NODE = docker-compose run --rm node
COMPOSE_UP_NODE = docker-compose up -d node
COMPOSE_UP_NODE_DEV = docker-compose up node_dev
COMPOSE_RUN_SHELLCHECK = docker-compose run --rm shellcheck
COMPOSE_RUN_DOCKERIZE = docker-compose run --rm dockerize
COMPOSE_RUN_TESTCAFE = docker-compose run --rm testcafe
ENVFILE ?= env.template

all:
	ENVFILE=env.example $(MAKE) envfile cleanDocker deps lint start test build clean

onPullRequest: envfile cleanDocker deps lint start test build clean

onMasterChange: envfile cleanDocker deps lint start test build deploy clean

envfile:
	cp -f $(ENVFILE) .env

deps:
	docker-compose pull node testcafe dockerize shellcheck
	$(COMPOSE_RUN_NODE) yarn install

shellNode:
	$(COMPOSE_RUN_NODE) bash

shellTestCafe:
	$(COMPOSE_RUN_TESTCAFE) sh

startDev:
	$(COMPOSE_UP_NODE_DEV)

start:
	$(COMPOSE_UP_NODE)
	$(COMPOSE_RUN_DOCKERIZE) -wait tcp://node:8080 -timeout 60s

lint:
	$(COMPOSE_RUN_SHELLCHECK) scripts/*.sh
	$(COMPOSE_RUN_NODE) yarn eslint test/*.ts

test:
	$(COMPOSE_RUN_TESTCAFE) scripts/test.sh
.PHONY: test

build:
	$(COMPOSE_RUN_NODE) scripts/build.sh

deploy:
	$(COMPOSE_RUN_NODE) scripts/deploy.sh

cleanDocker:
	docker-compose down --remove-orphans

clean:
	$(COMPOSE_RUN_NODE) scripts/clean.sh
	$(MAKE) cleanDocker
	rm -f .env