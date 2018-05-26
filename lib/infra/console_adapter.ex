defmodule Infra.ConsoleAdapter do
  @moduledoc """
  Adapter to use system's console.
  """
  require Logger

  @doc """
    Log PRs open time in the console.
  """
  @spec log_open_time(open_time :: non_neg_integer) :: :ok | {:error, String.t()}
  def log_open_time(open_time) do
    Logger.info("Average open-time (for currently opened PRs) is: " <> to_string(open_time))
  end
end
