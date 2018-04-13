#!/usr/bin/make -f

DEFAULT_PORT = 4000
DOCKER_IMAGE = bitwalker/alpine-elixir-phoenix:1.6.4
DOCKER_WORKING_DIR = /app
RUN_APP_CMD = 'mix phx.server'


# DOCKER PARAMS

# Clean everything when we quit
DOCKER_RM_ON_EXIT = --rm

# Enables inputs like Ctrl+C to quit
DOCKER_ALLOW_STDIN = -t -i

# Use local files so we can develop and see our change
DOCKER_MOUNT_LOCAL_FILES = -v $(shell pwd):${DOCKER_WORKING_DIR}


# COMMAND ARGS

PORT ?= ${DEFAULT_PORT}


run:
	docker run \
		${DOCKER_RM_ON_EXIT} \
		${DOCKER_ALLOW_STDIN} \
		${DOCKER_MOUNT_LOCAL_FILES} \
		-w ${DOCKER_WORKING_DIR} \
		-p ${PORT}:${DEFAULT_PORT} \
		${DOCKER_IMAGE} \
		sh -c ${RUN_APP_CMD}
