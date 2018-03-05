# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Poller.Repo.insert!(%Poller.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Poller.{Questions.PollQuestion, Answers.Answer, Repo, Auth.User}
import Ecto

# Create a dummy user
user_params = %{email: "user1@gmail.com", username: "user1", password: "password"}
user_changeset = User.new_changeset(%User{}, user_params)
user = case Repo.insert(user_changeset) do
  {:ok, user} -> user
  {:error, changeset} -> User |> Repo.get_by(email: changeset.changes.email)
end

# Create one poll question with some answers.

question_1_params = %{content: "Which is better, Golang or Elixir ?", user_id: user.id, tags: ["Development", "Web Technology", "Comparision"]}
answer_params = [%{content: "Golang"}, %{content: "Elixir"}]

Repo.transaction(fn ->
{:ok, question} = %PollQuestion{}
  |> PollQuestion.changeset(question_1_params)
  |> Repo.insert

Enum.map(answer_params, fn(params) ->
  changeset = question
              |> build_assoc(:answers)
              |> Answer.changeset(params)
  case Repo.insert(changeset) do
    {:ok, _answer} -> question
    {:error, changeset} -> Repo.rollback(:answer)
  end
end)
end)
