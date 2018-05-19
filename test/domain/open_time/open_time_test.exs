defmodule Domain.OpenTimeTest do
  use ExUnit.Case
  doctest Domain.OpenTime

  @today "2011-01-10T00:00:00Z"
  @two_days_before "2011-01-08T00:00:00Z"
  @three_days_before "2011-01-07T00:00:00Z"
  @four_days_before "2011-01-06T00:00:00Z"
  @invalid_date "2011-32-00"

  test "returns average number of days PRs have been opened until given date" do
    today = fn -> @today end

    prs = fn ->
      [
        %{created_at: @two_days_before},
        %{created_at: @three_days_before},
        %{created_at: @four_days_before}
      ]
    end

    avg_open_time = Domain.OpenTime.calculate(today, prs)

    assert avg_open_time == 3
  end

  test "omits PRs with an invalid date when calculating open time" do
    today = fn -> @today end

    prs = fn ->
      [
        %{created_at: @two_days_before},
        %{created_at: @three_days_before},
        %{created_at: @invalid_date},
        %{created_at: @four_days_before}
      ]
    end

    avg_open_time = Domain.OpenTime.calculate(today, prs)

    assert avg_open_time == 3
  end

  test "rounds the average open time" do
    today = fn -> @today end

    prs = fn ->
      [
        %{created_at: @two_days_before},
        %{created_at: @two_days_before},
        %{created_at: @three_days_before}
      ]
    end

    avg_open_time = Domain.OpenTime.calculate(today, prs)

    assert avg_open_time == 2
  end
end
