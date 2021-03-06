defmodule PrMetrics.MixProject do
  use Mix.Project

  def project do
    [
      app: :pr_metrics,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps(),

      # Docs
      name: "PR Metrics",
      source_url: "https://github.com/nicoespeon/pr_metrics"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:tentacat, "~> 1.0"},

      # Development only
      {:ex_doc, "~> 0.16", only: :dev, runtime: false},
      {:dialyxir, "~> 0.5", only: :dev, runtime: false},
      {:mix_test_watch, "~> 0.5", only: :dev, runtime: false},
      {:remix, "~> 0.0.1", only: :dev},

      # Test only
      {:mox, "~> 0.3", only: :test}
    ]
  end
end
