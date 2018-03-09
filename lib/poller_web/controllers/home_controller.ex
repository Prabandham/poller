defmodule PollerWeb.HomeController do
  use PollerWeb, :controller

  def index(conn, _params) do
    polls = Poller.Questions.PollQuestion 
            |> Poller.Repo.all() 
            |> Poller.Repo.preload([:user, answers: [:user_votes]])
    conn |> render("index.html", polls: polls)
  end
end