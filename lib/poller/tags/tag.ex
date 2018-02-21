defmodule Poller.Tags.Tag do
  use Ecto.Schema
  import Ecto.Changeset
  alias Poller.Tags.Tag


  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "tags" do
    field :color, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(%Tag{} = tag, attrs) do
    tag
    |> cast(attrs, [:name, :color])
    |> validate_required([:name, :color])
    |> unique_constraint(:name)
    |> unique_constraint(:color)
  end
end
