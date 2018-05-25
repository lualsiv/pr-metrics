defmodule PrMetrics do
  @moduledoc """
  PR Metrics application.
  """
  require Logger

  @access_token Application.get_env(:pr_metrics, :github_access_token)

  @doc """
  Log the average PRs open-time.
  """
  def main do
    # Instantiate the "I need to go out" adapters
    today = fn -> Date.utc_today() |> Date.to_iso8601() end

    # TODO: handle other scenarios
    {200, gh_prs, _} =
      Tentacat.Client.new(%{access_token: @access_token})
      |> Tentacat.Pulls.list("busbud", "integrations")

    prs = fn ->
      gh_prs
      |> Enum.map(fn gh_pr -> %{created_at: String.slice(gh_pr["created_at"], 0..9)} end)
    end

    # Instantiate the hexagon
    avg_open_time = Domain.OpenTime.calculate(today, prs)

    # Instantiate the "I need to enter" adapters

    # App logic, using left-side adapters
    Logger.info("Average open-time (for currently opened PRs) is: " <> to_string(avg_open_time))
  end
end
