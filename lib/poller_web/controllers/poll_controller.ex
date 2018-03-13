defmodule PollerWeb.PollController do
  use PollerWeb, :controller

  def create_poll(conn, params) do
    data = %{ status: "error", data: "Could not create Poll !"}
    conn
    |> render("create_poll.json", data: data)
  end
end
