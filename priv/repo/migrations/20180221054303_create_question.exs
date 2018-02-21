defmodule Poller.Repo.Migrations.CreateQuestion do
  use Ecto.Migration

  def change do
    create table(:question, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :content, :text
      add :user_id, references(:users, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create unique_index(:question, [:content])
    create index(:question, [:user_id])
  end
end
