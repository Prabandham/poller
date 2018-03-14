defmodule Poller.Questions.PollQuestion do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset
  alias Poller.Questions.PollQuestion

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "question" do
    field(:content, :string)
    field(:tags, {:array, :string})
    belongs_to(:user, Poller.Auth.User)
    has_many(:answers, Poller.Answers.Answer)

    timestamps()
  end

  @doc false
  def changeset(%PollQuestion{} = poll_question, attrs \\ %{}) do
    poll_question
    |> cast(attrs, [:content, :user_id, :tags])
    |> validate_required([:content, :user_id, :tags])
    |> unique_constraint(:content)
  end

  def create_poll_with_answers(question, answers, user_id, tags \\ []) do
    question_params = %{content: question, user_id: user_id, tags: tags}
    answer_params = Enum.map(answers, fn(answer) ->
      %{content: answer}
    end)
    Repo.transaction(fn ->
      changeset = %PollQuestion{} |> PollQuestion.changeset(question_params)
      question = case Repo.insert(changeset) do
        {:ok, question} -> question
        {:error, _changeset} -> nil
      end

      unless question == nil do
        Enum.map(answer_params, fn(params) ->
          changeset = question
                      |> build_assoc(:answers)
                      |> Answer.changeset(params)
          case Repo.insert(changeset) do
            {:ok, _answer} ->
              question_with_answers = question |> Poller.Repo.preload(:user, answers: [:user_votes])
              {:ok, question_with_answers}
            {:error, changeset} ->
              Repo.rollback(:answer)
              {:error, "Could not create Question"}
          end
        end)
      end
    end)
  end
end
