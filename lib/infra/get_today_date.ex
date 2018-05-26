defmodule Infra.GetToday.Date do
  @moduledoc """
  System's date implementation of `get_today`.
  """

  @doc """
  Returns date of today.
  """
  @spec get_today() :: String.t()
  def get_today do
    Date.utc_today() |> Date.to_iso8601()
  end
end
