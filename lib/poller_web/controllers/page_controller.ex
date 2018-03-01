defmodule PollerWeb.PageController do
  use PollerWeb, :controller

  def index(conn, _params) do
    changeset = Poller.Auth.User.new_changeset(%Poller.Auth.User{})
    conn
    |> render("index.html", changeset: changeset)
  end
end
