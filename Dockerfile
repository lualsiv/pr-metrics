FROM elixir:1.6.4-alpine

WORKDIR /app

ADD . /app

EXPOSE 4000

# Install hex for mix deps
RUN mix local.hex --force
