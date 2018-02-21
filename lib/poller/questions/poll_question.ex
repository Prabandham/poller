defmodule Poller.Questions.PollQuestion do
  use Ecto.Schema
  import Ecto.Changeset
  alias Poller.Questions.PollQuestion


  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "question" do
    field :content, :string
    belongs_to :user, Poller.Auth.User

    timestamps()
  end

  @doc false
  def changeset(%PollQuestion{} = poll_question, attrs) do
    poll_question
    |> cast(attrs, [:content, :user_id])
    |> validate_required([:content, :user_id])
    |> unique_constraint(:content)
  end
end
