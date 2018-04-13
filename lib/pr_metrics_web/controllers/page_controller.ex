defmodule PrMetricsWeb.PageController do
  use PrMetricsWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
