defmodule PollerWeb.Plugs.CheckAuth do
  @behaviour Plug
  import Plug.Conn
  import Phoenix.Controller, only: [put_flash: 3, redirect: 2]


  def init(opts), do: opts

  def call(conn, opts) do
    current_user = get_session(conn, :current_user)
    if current_user do
      IO.puts conn.request_path
      case conn.request_path do
        "/login" ->
          conn |> put_flash(:info, "Already Logged in.") |> redirect(to: "/home")
        "/register" ->
          conn |> put_flash(:info, "Already Registerd.") |> redirect(to: "/home")
        _ ->
            assign(conn, :current_user, current_user)
      end
    else
      conn
      |> put_flash(:error, "You need to be signed in to access that page.")
      |> redirect(to: "/login")
    end
  end
end