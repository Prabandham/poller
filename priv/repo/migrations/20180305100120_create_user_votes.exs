defmodule Poller.Repo.Migrations.CreateUserVotes do
  use Ecto.Migration

  def change do
    create table(:user_votes, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :answer_id, references(:answers, on_delete: :nothing, type: :binary_id)
      add :user_id, references(:users, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

#    create index(:user_votes, [:answer_id])
#    create index(:user_votes, [:user_id])
    create unique_index(:user_votes, [:answer_id, :user_id], name: :user_answer)
  end
end
