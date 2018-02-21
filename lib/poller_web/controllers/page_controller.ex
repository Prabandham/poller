defmodule PollerWeb.PageController do
  use PollerWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
