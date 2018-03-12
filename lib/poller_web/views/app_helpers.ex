defmodule PollerWeb.AppHelpers do
  @moduledoc """
  Conveniences for application specific stuff
  """

  use Phoenix.HTML

  def current_user(conn) do
    case Plug.Conn.get_session(conn, :current_user) do
      nil ->
        nil

      id ->
        key = "current_user_" <> id

        case ConCache.get(:poller_cache, key) do
          nil ->
            user = Poller.Auth.User |> Poller.Repo.get_by(id: id)
            ConCache.put(:poller_cache, key, user)
            ConCache.get(:poller_cache, key)

          map ->
            map
        end
    end
  end

  def logged_in?(conn) do
    case Plug.Conn.get_session(conn, :current_user) do
      nil -> false
      _ -> true
    end
  end
end
