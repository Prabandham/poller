defmodule PollerWeb.PageController do
  use PollerWeb, :controller

  def index(conn, _params) do
    conn
    |> put_layout("landing.html")
    |> render("index.html")
  end
end
