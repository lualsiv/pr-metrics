#!/usr/bin/make -f

DEFAULT_PORT = 4000

DOCKER_IMAGE = pr-metrics
DOCKER_WORKING_DIR = /app

START_CMD = 'iex -S mix'
TEST_CMD = 'mix test'
TEST_WATCH_CMD = 'mix test.watch'
FORMAT_CMD = 'mix format'

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

build:
	docker build -t ${DOCKER_IMAGE} .

start:
	$(eval PORT ?= ${DEFAULT_PORT})
	${DOCKER_RUN_CMD} \
		-p ${PORT}:${DEFAULT_PORT} \
		${DOCKER_IMAGE} \
		sh -c ${START_CMD} \

.PHONY: test
test:
	$(eval PORT ?= ${DEFAULT_PORT})
	${DOCKER_RUN_CMD} \
		-p ${PORT}:${DEFAULT_PORT} \
		${DOCKER_IMAGE} \
		sh -c ${TEST_CMD} \

test_watch:
	$(eval PORT ?= ${DEFAULT_PORT})
	${DOCKER_RUN_CMD} \
		-p ${PORT}:${DEFAULT_PORT} \
		${DOCKER_IMAGE} \
		sh -c ${TEST_WATCH_CMD} \

format:
	${DOCKER_RUN_CMD} \
		${DOCKER_IMAGE} \
		sh -c ${FORMAT_CMD} \

run:
	${DOCKER_RUN_CMD} \
		${DOCKER_IMAGE} \
		sh -c '${CMD}' \
