defmodule OpenTimeCalculator do
  @moduledoc """
  Calculate pull requests open-time.
  """

  def create do
    %{}
  end

  @doc """
  Returns the number of days opened until given date.

  ## Examples

      iex> OpenTimeCalculator.days_opened "2011-01-13T00:00:00Z", "2011-01-10T00:00:00Z"
      {:ok, 3}

      iex> OpenTimeCalculator.days_opened "2011-02-01T00:00:00Z", "2011-01-01T00:00:00Z"
      {:ok, 31}

      iex> OpenTimeCalculator.days_opened "2011-01-01T00:00:00Z", "2010-06-01T00:00:00Z"
      {:ok, 214}

      iex> OpenTimeCalculator.days_opened "2011-01-10T00:00:00Z", "2011-01-13T00:00:00Z"
      {:error, :created_date_in_the_future}
  """
  def days_opened date, created_date do
    {:ok, date_1, _} = DateTime.from_iso8601(date)
    {:ok, date_2, _} = DateTime.from_iso8601(created_date)

    diff_in_seconds = DateTime.diff date_1, date_2, :second
    seconds_per_day = 1 * 60 * 60 * 24
    diff_in_days = trunc(diff_in_seconds / seconds_per_day)

    if diff_in_days >= 0 do
      {:ok, diff_in_days}
    else
      {:error, :created_date_in_the_future}
    end
  end
end
