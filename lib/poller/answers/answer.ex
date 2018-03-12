defmodule Poller.Answers.Answer do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  alias Poller.Answers.Answer
  alias Poller.Auth.User

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "answers" do
    field(:content, :string)
    field(:votes, :integer)
    belongs_to(:poll_question, Poller.Questions.PollQuestion)
    has_many(:user_votes, Poller.Answers.UserVotes)

    timestamps()
  end

  @doc false
  def changeset(%Answer{} = answer, attrs) do
    answer
    |> cast(attrs, [:content, :votes])
    |> validate_required([:content])
    |> unique_constraint(:content_question, name: :question_answers)
  end

  def vote(answer_id, user_id) do
    user = Poller.Repo.get_by(User, id: user_id)
    answer = Poller.Repo.get_by(Answer, id: answer_id)
    # TODO do this all in a trasaction.
    answer
    |> check_if_user_has_already_voted(user_id)
    |> increment_votes
    |> register_users_vote(user)
  end

  defp check_if_user_has_already_voted(answer, user_id) do
    vote =
      Poller.Answers.UserVotes
      |> where(user_id: ^user_id, answer_id: ^answer.id)
      |> Poller.Repo.one()

    case vote do
      nil -> answer
      _ -> nil
    end
  end

  defp increment_votes(answer) when is_nil(answer), do: nil

  defp increment_votes(answer) do
    new_count = answer.votes + 1
    changeset = Answer.changeset(answer, %{votes: new_count})
    Poller.Repo.update!(changeset)
  end

  defp register_users_vote(nil, _user), do: nil

  defp register_users_vote(answer, user) do
    changeset =
      Poller.Answers.UserVotes.changeset(%Poller.Answers.UserVotes{}, %{
        answer_id: answer.id,
        user_id: user.id
      })

    case Poller.Repo.insert(changeset) do
      {:ok, _user_vote} ->
        answer |> Poller.Repo.preload([:user_votes, poll_question: [:user]])
    end
  end
end
