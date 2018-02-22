defmodule PollerWeb.AuthController do
    use PollerWeb, :controller

    def new(conn, _prams) do
        conn
        |> render("login.html")
    end
end