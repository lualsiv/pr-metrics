defmodule Domain.IGiveDates do
  @moduledoc """
  Behaviour to implement for a dates giver.

  It's role is to retrieve dates in a defined context (e.g. date of the system).
  """

  @doc """
  The date of today.
  """
  @callback today() :: String.t()
end
