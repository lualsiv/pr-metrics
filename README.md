# PR Metrics

This project aims to get metrics from Busbud Pull-Requests (e.g. evolution of PR open-time).

## 👣 Get started

First, you need to install [Docker](https://docs.docker.com/install/) if you don't have it.

Then, [create a GitHub AccessToken](https://blog.github.com/2013-05-16-personal-api-tokens/) with the **repo** scope.

> It needs to access your private repos to find Busbud ones.

Once you've got your token, run `make bootstrap TOKEN=<YOUR TOKEN>`.

> This builds the Docker image, installs deps and generates `config/config.secret.exs` with your token (it is not versioned 😉).

And, that's it 👐

## 🏃 Develop

If you want to run a custom command that is not in the following list, you can use `make run CMD='<your command>'`.

For instance: `make run CMD='elixir --version'` will run `elixir --version` in the Docker environment 🚢

### `make start` starts a server

Options:

* `PORT` to use a custom port (e.g. `make start PORT=4010`)

### `make test` runs tests

Options:

* `PORT` to use a custom port (e.g. `make test PORT=4011`)

### `make test_watch` runs tests in watch mode

Options:

* `PORT` to use a custom port (e.g. `make test_watch PORT=4011`)

### `make format` formats your code

💁 _At some point, this would be a pre-commit hook so you won't have to bother._

### `make docs` generates documentation of the application

### `make lint` lints your code

It may take some time the first time you run it because it generates the [Persistent Lookup Table (PLT)](https://hexdocs.pm/dialyxir/readme.html#with-explaining-stuff) to cache the output of the analysis.

## 💁 About

This project uses following technologies:

* [Docker](https://docs.docker.com/) to make development and deployment easy
* [Elixir](https://elixir-lang.org/) which is a dynamic, functional language designed for building scalable and maintainable applications.
