defmodule PollerWeb.PollController do
  @moduledoc false

  use PollerWeb, :controller

  def create_poll(conn, params) do
    data = %{status: "error", data: "Could not create Poll !"}
    question = params["question"]
    answers = params["answers"]
    user_id = params["user_id"]
    case Poller.Questions.PollQuestion.create_poll_with_answers(question, answers, user_id) do
      {:ok, question} -> #TODO broadcast to all users the new poll and send an Ok to the fontend so that the modal can close.
      {:error, _} -> #TODO send the necessary error to the user so that he can edit the question / answer and then submit again.
    end
    conn
    |> render("create_poll.json", data: data)
  end
end
