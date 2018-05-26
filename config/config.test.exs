use Mix.Config

config :pr_metrics,
  dates_giver: Mock.DatesGiver,
  prs_reader: Mock.PrsReader
