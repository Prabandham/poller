defmodule PollerWeb.HomeController do
  use PollerWeb, :controller

  def index(conn, _params) do
    conn |> render("index.html")
  end
end