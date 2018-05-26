defmodule PrMetrics do
  @moduledoc """
  PR Metrics application.
  """

  @doc """
  Log the average PRs open-time.
  """
  def main do
    # Yet, there is just one method per module.
    # That's OK because we only use one. Doing so is explicit.
    # But we'll move to Elixir Behaviours when we add more methods.

    # Instantiate the "I need to go out" adapters
    get_today = &Infra.GetToday.Date.get_today/0
    get_prs = &Infra.GetPrs.GitHub.get_prs/0

    # Instantiate the hexagon
    avg_open_time = Domain.OpenTime.calculate(get_today, get_prs)

    # In fact, we should be "injecting" the domain into the next adapters.
    # Using Behaviours too? Still need to figure this out…

    # Instantiate the "I need to enter" adapters
    log_open_time = &Infra.ConsoleAdapter.log_open_time/1

    # App logic, using left-side adapters
    log_open_time.(avg_open_time)
  end
end
