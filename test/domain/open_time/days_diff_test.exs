defmodule Domain.OpenTime.DaysDiffTest do
  use ExUnit.Case
  doctest Domain.OpenTime.DaysDiff

  @today "2011-01-10"
  @three_days_after "2011-01-13"
  @three_days_before "2011-01-07"
  @invalid_date "2011-32-00"
  @invalid_format "20110107"

  test "returns number of days between today and created date" do
    {:ok, days_opened} = Domain.OpenTime.DaysDiff.between(@today, @three_days_before)

    assert days_opened == 3
  end

  test "fails if created date is after today" do
    result = Domain.OpenTime.DaysDiff.between(@today, @three_days_after)

    assert result == {:error, :created_date_in_the_future}
  end

  test "fails if created date is invalid" do
    result = Domain.OpenTime.DaysDiff.between(@today, @invalid_date)

    assert result == {:error, :invalid_date}
  end

  test "fails if created date has invalid format" do
    result = Domain.OpenTime.DaysDiff.between(@today, @invalid_format)

    assert result == {:error, :invalid_format}
  end
end
