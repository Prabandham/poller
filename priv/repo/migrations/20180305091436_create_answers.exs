defmodule Poller.Repo.Migrations.CreateAnswers do
  use Ecto.Migration

  def change do
    create table(:answers, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :content, :string
      add :poll_question_id, references(:question, on_delete: :nothing, type: :binary_id)
      add :votes, :integer, default: 0

      timestamps()
    end

    create unique_index(:answers, [:content, :poll_question_id], name: :question_answers)
    create index(:answers, [:poll_question_id])
  end
end
