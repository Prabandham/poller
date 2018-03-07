defmodule PollerWeb.Controllers.PollController do
  use PollerWeb, :controller

#  def vote(conn, %{
#                    "poll" =>
#                        %{ "answer_id" => answer_id,
#                           "user_id" => user_id
#                        }
#                  } = params
#          ) do
#    vote = Poller.Answers.Answer.vote(answer_id, user_id)
#    case vote do
#      nil -> nil
#      _ ->  PollerWeb.Endpoint.broadcast("poll:home", "vote", )
#    end
#  end
end