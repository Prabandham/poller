defmodule PollerWeb.AuthController do
    use PollerWeb, :controller


    def new(conn, %{"login" => %{ "login" => login, "password" => password}} = _params) do
        case Poller.Auth.User.validate(login, password) do
            {:ok, user} -> 
                # TODO set user in session by encrypting it's id
                IO.inspect(user)
                IO.puts("Login success")
            {:error, _} ->
                IO.puts("Invalid Login")
        end
        conn
        |> redirect(to: "/")
    end

    def new_registration(conn, params) do
        IO.inspect(params)
        conn
        |> redirect(to: "/")
    end
end