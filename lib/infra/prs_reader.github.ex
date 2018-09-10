defmodule Infra.PrsReader.GitHub do
  @moduledoc """
  GitHub implementation of `Domain.IReadPrs`.

  It uses [GitHub API](https://developer.github.com/v3/pulls/#list-pull-requests) to request PRs information.
  """
  @behaviour Domain.IReadPrs

  @access_token Application.get_env(:pr_metrics, :github_access_token)

  def opened_prs do
    # TODO: handle other scenarios
    {200, gh_prs, _} =
      Tentacat.Client.new(%{access_token: @access_token})
      |> Tentacat.Pulls.list("nicoespeon", "gitgraph.js")

    gh_prs
    |> Enum.map(fn gh_pr -> %{created_at: String.slice(gh_pr["created_at"], 0..9)} end)
  end
end
