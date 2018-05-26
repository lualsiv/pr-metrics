defmodule Infra.GetPrs.GitHub do
  @moduledoc """
  GitHub implementation of `get_prs`.
  """

  @access_token Application.get_env(:pr_metrics, :github_access_token)

  @doc """
  Get PRs from GitHub.
  """
  @spec get_prs() :: [Domain.OpenTime.pr()]
  def get_prs do
    # TODO: handle other scenarios
    {200, gh_prs, _} =
      Tentacat.Client.new(%{access_token: @access_token})
      |> Tentacat.Pulls.list("busbud", "integrations")

    gh_prs
    |> Enum.map(fn gh_pr -> %{created_at: String.slice(gh_pr["created_at"], 0..9)} end)
  end
end
