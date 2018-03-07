defmodule PollerWeb.HomeView do
  use PollerWeb, :view

  def user_has_voted?(conn, answer) do
    user_id = current_user(conn).id
    has = answer.user_votes
    |> Enum.find(fn(x) -> x.user_id == user_id end)
    if is_nil(has), do: false, else: true
  end

  def percentage_for(nil, []), do: IO.puts("Came here")
  def percentage_for(answer, answers) do
    total_answers = answers
    |> Enum.count()
    if answer.votes == 0 do
      "0 %"
    else
      value = ((total_answers - answer.votes) / total_answers)*100
      Float.to_string(value) <> "%"
    end
  end

  def total_value_for_progress_bar(answers) do
    values_sum = answers
    |> Enum.map(fn(x) -> x.votes end)
    |> Enum.sum()
    case values_sum do
      0 -> 5
      x when x < 5 -> 5
      x when x < 10 -> 10
      x when x > 10 -> x + 10
      x when x > 100 -> x + 10
      x when x > 1000 -> x + 100
      x when x > 10000 -> x + 1000
    end
  end
end