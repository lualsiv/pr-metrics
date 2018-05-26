defmodule Domain.OpenTimeTest do
  use ExUnit.Case
  doctest Domain.OpenTime

  import Mox

  @today "2011-01-10"
  @two_days_before "2011-01-08"
  @three_days_before "2011-01-07"
  @four_days_before "2011-01-06"
  @invalid_date "2011-32-00"

  setup do
    Mock.DatesGiver
    |> stub(:today, fn -> @today end)

    :ok
  end

  test "returns average number of days PRs have been opened until given date" do
    Mock.PrsReader
    |> stub(:opened_prs, fn ->
      [
        %{created_at: @two_days_before},
        %{created_at: @three_days_before},
        %{created_at: @four_days_before}
      ]
    end)

    avg_open_time = Domain.OpenTime.calculate()

    assert avg_open_time == 3
  end

  test "omits PRs with an invalid date when calculating open time" do
    Mock.PrsReader
    |> stub(:opened_prs, fn ->
      [
        %{created_at: @two_days_before},
        %{created_at: @three_days_before},
        %{created_at: @invalid_date},
        %{created_at: @four_days_before}
      ]
    end)

    avg_open_time = Domain.OpenTime.calculate()

    assert avg_open_time == 3
  end

  test "rounds the average open time" do
    Mock.PrsReader
    |> stub(:opened_prs, fn ->
      [
        %{created_at: @two_days_before},
        %{created_at: @two_days_before},
        %{created_at: @three_days_before}
      ]
    end)

    avg_open_time = Domain.OpenTime.calculate()

    assert avg_open_time == 2
  end

  test "returns 0 if there are no PR" do
    Mock.PrsReader
    |> stub(:opened_prs, fn -> [] end)

    avg_open_time = Domain.OpenTime.calculate()

    assert avg_open_time == 0
  end
end
