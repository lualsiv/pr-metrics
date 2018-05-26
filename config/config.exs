use Mix.Config

# Configure the "I need to go out" adapters
config :pr_metrics,
  dates_giver: Infra.DatesGiver.System,
  prs_reader: Infra.PrsReader.GitHub

# Import environment specific config.
if Mix.env() == :test, do: import_config("config.test.exs")

# Import non-versioned config file with secrets.
import_config "config.secret.exs"
