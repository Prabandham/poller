defmodule PollerWeb.HomeView do
  use PollerWeb, :view

  def user_has_voted?(user_id, answer) do
    has =
      answer.user_votes
      |> Enum.find(fn x -> x.user_id == user_id end)

    if is_nil(has), do: false, else: true
  end

  def percentage_for(nil, []), do: IO.puts("Came here")

  def percentage_for(answer, answers) do
    total_votes =
      answers
      |> Enum.map(fn x -> x.votes end)
      |> Enum.count()

    case answer.votes do
      0 ->
        "0 %"

      _ ->
        value = total_value_for_progress_bar(answers) - total_votes
        values = 1.0 * answer.votes / value * 100

        percent_string =
          values
          |> Float.round(2)
          |> Float.to_string()

        percent_string <> "%"
    end
  end

  def total_value_for_progress_bar(answers) do
    # We take sum of all votes for this poll and add a buffer of 10, so that the value of polls will keep increasing.
    total_votes =
      answers
      |> Enum.map(fn x -> x.votes end)
      |> Enum.sum()

    total_votes + 10
  end

  def sort_answers(answers) do
    answers
    |> Enum.sort_by(& &1.votes)
    |> Enum.reverse()
  end
end
