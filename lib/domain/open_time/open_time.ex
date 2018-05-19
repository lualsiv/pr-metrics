defmodule Domain.OpenTime do
  @moduledoc """
  Calculate Pull Requests (PRs) open-time.
  """

  @type pr :: %{created_at: String.t()}

  @doc """
  Returns the average number of days PRs have been opened until today.
  """
  @spec calculate(today :: (() -> String.t()), prs :: (() -> [pr])) :: non_neg_integer
  def calculate(today, prs) do
    prs_open_times_until(today.(), prs.())
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
