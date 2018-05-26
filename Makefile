#!/usr/bin/make -f

DEFAULT_PORT = 4000
DEFAULT_TEST_PORT = 4001

DOCKER_IMAGE = pr-metrics
DOCKER_WORKING_DIR = /app

INSTALL_CMD = 'mix deps.get'
START_CMD = 'iex -S mix'
TEST_CMD = 'mix test'
TEST_WATCH_CMD = 'mix test.watch'
FORMAT_CMD = 'mix format'
DOCS_CMD = 'mix docs'
LINT_CMD = 'mix dialyzer'

# DOCKER PARAMS
# Clean everything when we quit
DOCKER_RM_ON_EXIT = --rm

# Enables inputs like Ctrl+C to quit
DOCKER_ALLOW_STDIN = -t -i

# Use local files so we can develop and see our change
DOCKER_MOUNT_LOCAL_FILES = -v $(shell pwd):${DOCKER_WORKING_DIR}

DOCKER_RUN_CMD = docker run \
	${DOCKER_RM_ON_EXIT} \
	${DOCKER_ALLOW_STDIN} \
	${DOCKER_MOUNT_LOCAL_FILES} \
	-w ${DOCKER_WORKING_DIR} \

.PHONY: bootstrap
bootstrap: build install generate_secret

.PHONY: build
build:
	docker build -t ${DOCKER_IMAGE} .

.PHONY: install
install:
	${DOCKER_RUN_CMD} \
		${DOCKER_IMAGE} \
		sh -c ${INSTALL_CMD} \

# Current implementation is basic because config is really small.
# If you want to add more => refactor with a more maintainable solution first.
.PHONY: generate_secret
generate_secret:
	$(eval TOKEN ?= SHOULD BE FILLED)
	echo 'use Mix.Config\n\nconfig :pr_metrics,\n  github_access_token: "${TOKEN}"' > ./config/config.secret.exs

.PHONY: start
start:
	$(eval PORT ?= ${DEFAULT_PORT})
	${DOCKER_RUN_CMD} \
		-p ${PORT}:${DEFAULT_PORT} \
		${DOCKER_IMAGE} \
		sh -c ${START_CMD} \

.PHONY: test
test:
	$(eval PORT ?= ${DEFAULT_TEST_PORT})
	${DOCKER_RUN_CMD} \
		-p ${PORT}:${DEFAULT_PORT} \
		${DOCKER_IMAGE} \
		sh -c ${TEST_CMD} \

.PHONY: test_watch
test_watch:
	$(eval PORT ?= ${DEFAULT_TEST_PORT})
	${DOCKER_RUN_CMD} \
		-p ${PORT}:${DEFAULT_PORT} \
		${DOCKER_IMAGE} \
		sh -c ${TEST_WATCH_CMD} \

.PHONY: format
format:
	${DOCKER_RUN_CMD} \
		${DOCKER_IMAGE} \
		sh -c ${FORMAT_CMD} \

.PHONY: docs
docs:
	${DOCKER_RUN_CMD} \
		${DOCKER_IMAGE} \
		sh -c ${DOCS_CMD} \

.PHONY: lint
lint:
	${DOCKER_RUN_CMD} \
		${DOCKER_IMAGE} \
		sh -c ${LINT_CMD} \

.PHONY: run
run:
	${DOCKER_RUN_CMD} \
		${DOCKER_IMAGE} \
		sh -c '${CMD}' \
