defmodule Infra.DatesGiver.System do
  @moduledoc """
  System implementation of `Domain.IGiveDates`.
  """
  @behaviour Domain.IGiveDates

  def today, do: Date.utc_today() |> Date.to_iso8601()
end
