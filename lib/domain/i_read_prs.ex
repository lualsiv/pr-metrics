defmodule Domain.IReadPrs do
  @moduledoc """
  Behaviour to implement for a PRs reader.

  It's role is to get PRs information from a source.
  """

  @doc """
  Get PRs which are opened.
  """
  @callback opened_prs() :: [Domain.OpenTime.pr()]
end
