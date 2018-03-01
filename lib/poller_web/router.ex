defmodule PollerWeb.Router do
  use PollerWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PollerWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    post "/auth/new", AuthController, :new
    post "/new/registration", AuthController, :new_registration
  end

  # Other scopes may use custom stacks.
  # scope "/api", PollerWeb do
  #   pipe_through :api
  # end
end
