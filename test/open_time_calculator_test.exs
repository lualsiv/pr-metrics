defmodule OpenTimeCalculatorTest do
  use ExUnit.Case
  doctest OpenTimeCalculator

  test "returns number of days opened until given date" do
    today = "2011-01-10T00:00:00Z"
    three_days_before = "2011-01-07T00:00:00Z"

    {:ok, days_opened} = OpenTimeCalculator.days_opened today, three_days_before

    assert days_opened == 3
  end

  test "fails if given date is before created date" do
    today = "2011-01-10T00:00:00Z"
    three_days_after = "2011-01-13T00:00:00Z"

    result = OpenTimeCalculator.days_opened today, three_days_after

    assert result == {:error, :created_date_in_the_future}
  end
end
