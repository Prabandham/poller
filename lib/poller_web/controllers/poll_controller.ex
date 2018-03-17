defmodule PollerWeb.PollController do
  @moduledoc false

  use PollerWeb, :controller

  def create_poll(conn, params) do
    question = params["question"]
    answers = params["answers"]
    user_id = params["user_id"]

    data =
      case Poller.Questions.PollQuestion.create_poll_with_answers(question, answers, user_id) do
        {:ok, questions} ->
          [question_response | _] = questions
          {:ok, question} = question_response

          question
          |> Poller.Repo.preload(:user, answers: [:user_votes])

          # TODO broadcast to all users the new poll and send an Ok to the fontend so that the modal can close.

          %{status: "success"}

        {:error, _} ->
          %{status: "error", message: "Could not create Poll !"}
      end

    conn
    |> render("create_poll.json", data: Poison.encode!(data))
  end
end
