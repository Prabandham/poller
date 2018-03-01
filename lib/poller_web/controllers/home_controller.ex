defmodule PollerWeb.HomeController do
    use PollerWeb, :controller
    # plug PollerWeb.Plugs.CheckAuth

    def index(conn, _params) do
        conn
        |> render("index.html")
    end
end