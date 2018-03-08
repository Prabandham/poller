defmodule Poller.Answers.UserVotes do
  use Ecto.Schema
  import Ecto.Changeset
  alias Poller.Answers.UserVotes


  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "user_votes" do
    belongs_to :answer, Poller.Answers.Answer
    belongs_to :user, Poller.Auth.User

    timestamps()
  end

  @doc false
  def changeset(%UserVotes{} = user_votes, attrs) do
    user_votes
    |> cast(attrs, [:answer_id, :user_id])
    |> validate_required([:answer_id, :user_id])
  end

  def get_answer(vote) do
    Poller.Answers.Answer
    |> Poller.Repo.get(vote.id)
  end

  def get_all_answers(vote) do
    question = Poller.Questions.PollQuestion
    |> Poller.Repo.get(vote.poll_question_id)
    |> Poller.Repo.preload(:answers)
    question.answers
  end
end
