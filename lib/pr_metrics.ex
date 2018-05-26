defmodule PrMetrics do
  @moduledoc """
  PR Metrics application.
  """

  @doc """
  Log the average PRs open-time.
  """
  def main do
    # Instantiate the hexagon
    calculate_open_time = &Domain.OpenTime.calculate/0

    # In fact, we should be "injecting" the domain into the next adapters.
    # Using Behaviours too? Still need to figure this out…

    # Instantiate the "I need to enter" adapters
    log_open_time = &Infra.ConsoleAdapter.log_open_time/1

    # App logic, using left-side adapters
    log_open_time.(calculate_open_time)
  end
end
