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

## Create 100 dummy user
users = User |> Repo.all
if Enum.count(users) <= 10 do
  list = Enum.to_list(1..100)
  Enum.map(list, fn(_x) ->
    name = Faker.Name.name()
    formatted_name = name
          |> String.split(" ")
          |> Enum.join(".")
          |> String.downcase
    email = formatted_name <> "@gmail.com"
    user_params = %{email: email, username: name, password: "passowrd"}
    user_changeset = User.new_changeset(%User{}, user_params)
    user = case Repo.insert(user_changeset) do
      {:ok, user} -> user
      {:error, changeset} -> User |> Repo.get_by(email: changeset.changes.email)
    end
  end)
end

questions = [
              %{"Which is the better web development framework in 2017 ????" =>
                %{
                    "answers" => ["Golang", "Elixir", "Ruby On Rails", "PHP", "Java"],
                    "tags" => ["Development", "Comparision", "Web", "2018 Tech Stack"]
                }
              },
              %{"Which would you choose if for the front end ?????" =>
                 %{
                    "answers" => ["React JS", "Angular", "Vue.JS", "Sammy JS", "NONE"],
                    "tags" => ["Development", "Comparision", "Web", "2018 Tech Stack"]
                 }
              },
              %{"Which would you choose if for the front end ?????" =>
                 %{
                    "answers" => ["React JS", "Angular", "Vue.JS", "Sammy JS", "NONE"],
                    "tags" => ["Development", "Comparision", "Web", "2018 Tech Stack"]
                 }
              },
            ]
users = User |> Repo.all()

# Create poll question with some answers.
Enum.map(questions, fn(hash) ->
  user = Enum.random(users)
  [question | _] = Map.keys(hash)
  question_params = %{content: question, user_id: user.id, tags: hash[question]["tags"]}
  answer_params = Enum.map(hash[question]["answers"], fn(answer) ->
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
          {:ok, _answer} -> question
          {:error, changeset} -> Repo.rollback(:answer)
        end
      end)
    end
  end)
end)
