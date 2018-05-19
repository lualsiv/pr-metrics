defmodule Domain.OpenTime.DaysDiff do
  @moduledoc """
  Calculate the number of days between two dates.
  """

  @doc """
  Returns the number of days between today and created date.

  ## Examples

      iex> Domain.OpenTime.DaysDiff.between "2011-01-13T00:00:00Z", "2011-01-10T00:00:00Z"
      {:ok, 3}

      iex> Domain.OpenTime.DaysDiff.between "2011-02-01T00:00:00Z", "2011-01-01T00:00:00Z"
      {:ok, 31}

      iex> Domain.OpenTime.DaysDiff.between "2011-01-01T00:00:00Z", "2010-06-01T00:00:00Z"
      {:ok, 214}

      iex> Domain.OpenTime.DaysDiff.between "2011-01-10T00:00:00Z", "2011-01-13T00:00:00Z"
      {:error, :created_date_in_the_future}
  """
  @spec between(today :: String.t(), created_date :: String.t()) ::
          {:ok, non_neg_integer} | {:error, atom}
  def between(today, created_date) do
    case diff_in_days(today, created_date) do
      {:ok, diff_in_days} when diff_in_days >= 0 ->
        {:ok, diff_in_days}

      {:ok, _diff_in_days} ->
        {:error, :created_date_in_the_future}

      err ->
        err
    end
  end

  @spec diff_in_days(String.t(), String.t()) :: {:ok, integer} | {:error, atom}
  defp diff_in_days(date_1, date_2) do
    with {:ok, date_1_iso8601, _} <- DateTime.from_iso8601(date_1),
         {:ok, date_2_iso8601, _} <- DateTime.from_iso8601(date_2) do
      diff_in_seconds = DateTime.diff(date_1_iso8601, date_2_iso8601, :second)
      seconds_per_day = 1 * 60 * 60 * 24
      diff_in_days = trunc(diff_in_seconds / seconds_per_day)

      {:ok, diff_in_days}
    end
  end
end
