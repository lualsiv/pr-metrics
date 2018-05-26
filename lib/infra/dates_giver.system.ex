defmodule Infra.DatesGiver.System do
  @moduledoc """
  System implementation of `Domain.IGiveDates`.

  It uses the clock of the system to determine current time.
  """
  @behaviour Domain.IGiveDates

  def today, do: Date.utc_today() |> Date.to_iso8601()
end
