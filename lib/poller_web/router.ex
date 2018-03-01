defmodule PollerWeb.Router do
  use PollerWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :check_auth do
    plug PollerWeb.Plugs.CheckAuth#, repo: Poller.Repo
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  # This will have all non logged in routes.
  scope "/", PollerWeb do
    pipe_through :browser # Use the default browser stack

    get "/",                    PageController,   :index

    # Auth Routes
    get "/login",               AuthController,   :login
    get "/register",            AuthController,   :register
    post "/auth/new",           AuthController,   :new
    post "/new/registration",   AuthController,   :new_registration
  end

  # This will handle all logged in routes
  scope "/", PollerWeb do
    pipe_through [:browser, :check_auth]


    # Main Application
    get "/home",                HomeController,   :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", PollerWeb do
  #   pipe_through :api
  # end
end
