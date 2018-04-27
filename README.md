# PR Metrics

This project aims to get metrics from Busbud Pull-Requests (e.g. evolution of PR open-time).

## Get started

You need to install [Docker](https://docs.docker.com/install/) if you don't have it. And that's pretty much it 👐

> The first time you run Docker, you need an internet connection because it'll certainly download images from public repositories.

Commands are listed in a Makefile, so you don't have to memorize Docker commands params.

Available commands are:

* `make install` to install dependencies
* `make start` to start a development server, with following options:
  * `PORT` to use a custom port (e.g. `make start PORT=4010`)
* `make test` to run project tests
  * `PORT` to use a custom port (e.g. `make test PORT=4011`)

If you want to run a custom command that is not in previous list, you can use `make run COMMAND='<your command>'` (e.g. `make run COMMAND='elixir --version'` will run `elixir --version` in the Docker environment).

## Contribute

This project uses following technologies:

* [Docker](https://docs.docker.com/) to make development and deployment easy
* [Elixir](https://elixir-lang.org/) which is a dynamic, functional language designed for building scalable and maintainable applications.
