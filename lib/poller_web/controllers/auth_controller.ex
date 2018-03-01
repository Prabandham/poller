defmodule PollerWeb.AuthController do
  use PollerWeb, :controller

  plug :scrub_params, "login" when action in [:new]
  plug :scrub_params, "user" when action in [:new_registration]


  def login(conn, _params) do
    changeset = Poller.Auth.User.new_changeset(%Poller.Auth.User{})
    conn
    |> render("login.html", changeset: changeset)
  end

  def register(conn, _params) do
    changeset = Poller.Auth.User.new_changeset(%Poller.Auth.User{})
    conn
    |> render("register.html", changeset: changeset)
  end

  def new(conn, %{"login" => %{ "login" => login, "password" => password}} = _params) do
    case Poller.Auth.User.validate(login, password) do
      {:ok, user} ->
        conn
        |> put_session(:current_user, user.id) #TODO encrypt this.
        |> put_flash(:info, "Welcome #{user.username}")
        |> redirect(to: "/home")
      {:error, _} ->
        conn
        |> put_flash(:error, "Invalid login credentials")
        |> render("login.html")
    end
  end

  def new_registration(conn, params) do
    changeset = Poller.Auth.User.new_changeset(%Poller.Auth.User{}, params["user"])
    case Poller.Repo.insert(changeset) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Registration Successful ! Please login to continue.")
        |> redirect(to: "/login")
      {:error, changeset} ->
        IO.inspect(changeset.errors)
        conn
        |> put_flash(:error, "Registration Not Successful ! Please try again.")
        |> render("register.html", changeset: changeset)
    end
  end
end