defmodule PrMetrics do
  @moduledoc """
  PR Metrics application.
  """
  require Logger

  @doc """
  Log the average PRs open-time.
  """
  def main do
    # Instantiate the "I need to go out" adapters
    today = fn -> Date.utc_today() |> Date.to_iso8601() end
    prs = fn -> [] end

    # Instantiate the hexagon
    avg_open_time = Domain.OpenTime.calculate(today, prs)

    # Instantiate the "I need to enter" adapters

    # App logic, using left-side adapters
    Logger.info("Average open-time is: " <> to_string(avg_open_time))
  end
end
