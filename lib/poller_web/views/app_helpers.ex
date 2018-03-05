defmodule PollerWeb.AppHelpers do
  @moduledoc """
  Conveniences for application specific stuff
  """

  use Phoenix.HTML

  def current_user(conn) do
    case Plug.Conn.get_session(conn, :current_user) do
      nil -> nil
      id  -> Poller.Auth.User |> Poller.Repo.get_by(id: id)
    end
  end

  def logged_in?(conn) do
    case Plug.Conn.get_session(conn, :current_user) do
      nil -> false
      _ -> true
    end
  end
end
