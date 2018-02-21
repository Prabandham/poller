defmodule Poller.Auth.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Poller.Auth.User
  require Ecto.Query


  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :email, :string
    field :password, :string, virtual: true
    field :hash_password, :string
    field :username, :string
    field :verification_code, :string

    has_many :poll_questions, Poller.Questions.PollQuestion

    timestamps()
  end

  @doc false
  def new_changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:username, :email, :password])
    |> validate_required([:username, :email, :password])
    |> unique_constraint(:username)
    |> unique_constraint(:email)
    |> validate_length(:password, min: 8)
    |> validate_format(:email, ~r/@/)
    |> generate_hash_password
    |> generate_verification_code
    # |> send_verification_mailer #May be it is better to do this in the controller and this can be a background job.
  end

  def update_changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :password])
    |> validate_required([:email, :password])
    |> generate_hash_password
  end

  def validate(login, password) do
    user = User
    |> Ecto.Query.where(email: ^login)
    |> Ecto.Query.or_where(username: ^login)
    |> Poller.Repo.one
    Comeonin.Argon2.check_pass(user, password, [hash_key: :hash_password])
  end

  defp generate_hash_password(changeset) do
    %{password_hash: hashed_password} = Comeonin.Argon2.add_hash(changeset.changes.password)
    changeset
    |> put_change(:hash_password, hashed_password)
    |> put_change(:password, "")
  end

  defp generate_verification_code(changeset) do
    code = Poller.Utilities.RandomTextGenerator.make(8)
    changeset
    |> put_change(:verification_code, code)
  end

  defp send_verification_mailer(changeset) do
  end
end
