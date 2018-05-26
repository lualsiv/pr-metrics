defmodule Domain.OpenTimeTest do
  use ExUnit.Case
  doctest Domain.OpenTime

  @today "2011-01-10"
  @two_days_before "2011-01-08"
  @three_days_before "2011-01-07"
  @four_days_before "2011-01-06"
  @invalid_date "2011-32-00"

  test "returns average number of days PRs have been opened until given date" do
    get_today = fn -> @today end

    get_prs = fn ->
      [
        %{created_at: @two_days_before},
        %{created_at: @three_days_before},
        %{created_at: @four_days_before}
      ]
    end

    avg_open_time = Domain.OpenTime.calculate(get_today, get_prs)

    assert avg_open_time == 3
  end

  test "omits PRs with an invalid date when calculating open time" do
    get_today = fn -> @today end

    get_prs = fn ->
      [
        %{created_at: @two_days_before},
        %{created_at: @three_days_before},
        %{created_at: @invalid_date},
        %{created_at: @four_days_before}
      ]
    end

    avg_open_time = Domain.OpenTime.calculate(get_today, get_prs)

    assert avg_open_time == 3
  end

  test "rounds the average open time" do
    get_today = fn -> @today end

    get_prs = fn ->
      [
        %{created_at: @two_days_before},
        %{created_at: @two_days_before},
        %{created_at: @three_days_before}
      ]
    end

    avg_open_time = Domain.OpenTime.calculate(get_today, get_prs)

    assert avg_open_time == 2
  end

  test "returns 0 if there are no PR" do
    get_today = fn -> @today end
    get_empty_prs = fn -> [] end

    avg_open_time = Domain.OpenTime.calculate(get_today, get_empty_prs)

    assert avg_open_time == 0
  end
end
