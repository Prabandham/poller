defmodule PollerWeb.Plugs.CheckAuth do
  @moduledoc false

  @behaviour Plug
  import Plug.Conn
  import Phoenix.Controller, only: [put_flash: 3, redirect: 2]

  def init(opts), do: opts

  def call(conn, _opts) do
    current_user = get_session(conn, :current_user)

    if current_user do
      case conn.request_path do
        "/login" ->
          conn |> put_flash(:info, "Already Logged in.") |> redirect(to: "/home") |> halt()

        "/register" ->
          conn |> put_flash(:info, "Already Registerd.") |> redirect(to: "/home") |> halt()

        _ ->
          assign(conn, :current_user, current_user)
      end
    else
      # User is not logged in so redirect him to login
      # This could have been easily handled in the routes by creating a new pipeline.
      # But I am doing it here as this is more explicit. And this also allows us to write all routes in one pipeline block
      case conn.request_path do
        x when x in ["/", "/login", "/register", "/auth/new", "/new/registration"] ->
          conn

        _ ->
          conn |> put_flash(:error, "Please Login First.") |> redirect(to: "/login") |> halt()
      end
    end
  end
end
