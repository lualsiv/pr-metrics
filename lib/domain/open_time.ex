defmodule Domain.OpenTime do
  @moduledoc """
  Calculate PRs open-time.
  """

  @type pr :: %{created_at: String.t()}

  @dates_giver Application.get_env(:pr_metrics, :dates_giver)
  @prs_reader Application.get_env(:pr_metrics, :prs_reader)

  @doc """
  Returns the average number of days PRs have been opened until today.
  """
  @spec calculate() :: non_neg_integer
  def calculate() do
    prs_open_times_until(@dates_giver.today(), @prs_reader.opened_prs())
    |> average
  end

  @spec prs_open_times_until(today :: String.t(), prs :: [pr]) :: [non_neg_integer]
  defp prs_open_times_until(today, prs) do
    prs
    |> Enum.map(fn pr -> pr.created_at end)
    |> Enum.flat_map(fn created_at ->
      case Domain.OpenTime.DaysDiff.between(today, created_at) do
        {:ok, days_opened} -> [days_opened]
        {:error, _} -> []
      end
    end)
  end

  @spec average(values :: [non_neg_integer]) :: non_neg_integer
  defp average([]), do: 0
  defp average(values), do: round(Enum.sum(values) / Enum.count(values))
end
