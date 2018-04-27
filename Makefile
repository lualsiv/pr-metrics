#!/usr/bin/make -f

DEFAULT_DEV_PORT = 4000
DEFAULT_TEST_PORT = 4001

DOCKER_IMAGE = bitwalker/alpine-elixir:1.6.4
DOCKER_WORKING_DIR = /app

INSTALL_DEPS_CMD = 'mix deps.get'
START_CMD = 'iex -S mix'
TEST_CMD = 'mix test'

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

install:
	${DOCKER_RUN_CMD} \
		${DOCKER_IMAGE} \
		sh -c ${INSTALL_DEPS_CMD} \

start:
	$(eval PORT ?= ${DEFAULT_DEV_PORT})
	${DOCKER_RUN_CMD} \
		-p ${PORT}:${DEFAULT_DEV_PORT} \
		${DOCKER_IMAGE} \
		sh -c ${START_CMD} \

.PHONY: test
test:
	$(eval PORT ?= ${DEFAULT_TEST_PORT})
	${DOCKER_RUN_CMD} \
		-p ${PORT}:${DEFAULT_TEST_PORT} \
		${DOCKER_IMAGE} \
		sh -c ${TEST_CMD} \

run:
	${DOCKER_RUN_CMD} \
		${DOCKER_IMAGE} \
		sh -c '${COMMAND}' \
