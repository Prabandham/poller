defmodule PollerWeb.HomeController do
  use PollerWeb, :controller
  import Ecto.Query

  def index(conn, _params) do
    # NOTE this should also suport order, insense user should be able to order by which has highest votes, or latest polls and so on.
    polls =
      Poller.Questions.PollQuestion
      |> Ecto.Query.order_by(desc: :inserted_at)
      |> Poller.Repo.all()
      |> Poller.Repo.preload([:user, answers: [:user_votes]])

    conn |> render("index.html", polls: polls)
  end
end
