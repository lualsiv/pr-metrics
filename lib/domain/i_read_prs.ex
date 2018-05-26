defmodule Domain.IReadPrs do
  @moduledoc """
  Read PRs information from a source.
  """

  @doc """
  Get PRs which are opened.
  """
  @callback opened_prs() :: [Domain.OpenTime.pr()]
end
