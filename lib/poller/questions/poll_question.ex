defmodule Poller.Questions.PollQuestion do
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

  def create_poll_with_answers(question, answeers) do

  end
end
