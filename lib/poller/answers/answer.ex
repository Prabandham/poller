defmodule Poller.Answers.Answer do
  use Ecto.Schema
  import Ecto.Changeset
  alias Poller.Answers.Answer


  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "answers" do
    field :content, :string
    field :votes, :integer
    belongs_to :poll_question, Poller.Questions.PollQuestion

    timestamps()
  end

  @doc false
  def changeset(%Answer{} = answer, attrs) do
    answer
    |> cast(attrs, [:content])
    |> validate_required([:content])
    |> unique_constraint(:content_question, name: :question_answers)
  end
end
