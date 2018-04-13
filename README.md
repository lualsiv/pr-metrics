# PR Metrics

This project aims to get metrics from Busbud Pull-Requests (e.g. evolution of PR open-time).

## Get started

You need to install [Docker](https://docs.docker.com/install/) if you don't have it. And that's pretty much it 👐

> The first time you run Docker, you need an internet connection because it'll certainly download images from public repositories.

Commands are listed in a Makefile, so you don't have to memorize Docker commands params.

Available commands are:

* `make run` to start a development server, with following options:
  * `make run PORT=4010` to use port `4010` instead of the default one
* `make test` to run project tests
  * `make test PORT=4011` to use port `4011` instead of the default one

## Contribute

This project uses following technologies:

* [Docker](https://docs.docker.com/) to make development and deployment easy
* [Phoenix](http://www.phoenixframework.org/), which is a web framework based on [Elixir](https://elixir-lang.org/)
  * Phoenix has [a couple of dependencies](https://hexdocs.pm/phoenix/installation.html#content). But you don't have to install them if you use Docker 😉

## Learn more

### Phoenix

* Official website: http://www.phoenixframework.org/
* Guides: http://phoenixframework.org/docs/overview
* Docs: https://hexdocs.pm/phoenix
* Mailing list: http://groups.google.com/group/phoenix-talk
* Source: https://github.com/phoenixframework/phoenix
