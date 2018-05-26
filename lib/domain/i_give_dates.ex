defmodule Domain.IGiveDates do
  @moduledoc """
  Retrieve dates in a defined context (e.g. date of the system).
  """

  @doc """
  The date of today.
  """
  @callback today() :: String.t()
end
