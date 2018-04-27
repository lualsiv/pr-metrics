FROM elixir:1.6.4-alpine

# Install required environment deps
RUN apk add --no-cache \
  inotify-tools

WORKDIR /app

ADD . /app

EXPOSE 4000

# Install hex for mix deps
RUN mix local.hex --force
