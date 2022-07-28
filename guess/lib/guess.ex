defmodule Guess do
  use Application

  def start(_,_) do
    run()
    {:ok, self()}
  end

  def run() do
    IO.puts("\nLet's play Guess the Number?\n" )

    IO.gets("Pick a difficult level (1, 2 or 3): ")

    |> parse_input()
    |> pickup_number()
    |> play()
  end

  def play(picked_number) do
    IO.gets("I have my number already. Tell me your guess, buddy: ")
    |> parse_input()
    |> guess(picked_number, 1, [])

  end

  def guess(user_input, picked_number, cont, list) when user_input > picked_number do
    add_user_input(picked_number, cont, list)
    IO.gets("This number is too high. Try a lower one: ")
    |> parse_input()
    |> guess(picked_number, cont + 1, list)
  end

  def guess(user_input, picked_number, cont, list) when user_input < picked_number do
    add_user_input(picked_number, cont, list)
    IO.gets("This number is too low. Try a bigger one: ")
    |> parse_input()
    |> guess(picked_number, cont + 1, list)
  end

  def guess(_user_input, _picked_number, cont) do
    IO.puts("You got it in #{cont} guesses")
    show_score(cont)
  end

  def show_score(guesses) when guesses > 7 do
    IO.puts("Better luck next time")
  end

  def show_score(guesses) do
    {_, msg} = %{1..1 => "You're a mind reader!",
      2..4 => "Most Impressive!",
      5..7 => "You can do better than this! "}
      |> Enum.find(fn {range, _} ->
        Enum.member?(range, guesses)
      end)
    IO.puts(msg)
  end

  def add_user_input(input, cont, list) when cont > 1 do
    list ++ input
    |>verify_number(input)
  end

  def add_user_input(input, _cont, list) do
    list ++ input
  end

  def verify_number(list, user_input) do
    Enum.find(list, fn(s) -> s == user_input
      #IO.puts("Number already tried")
      #Enum.uniq(list)
    end)
  end

  def pickup_number(level) do
    level
    |> get_range()
    |> Enum.random()
  end

  def parse_input(:error) do
    IO.puts("Invalid input")
      run()
  end

  def parse_input({num, _}) do
    num
  end

  def parse_input(data) do
    data
    |> Integer.parse()
    |> parse_input()
  end

  def get_range(level) do
    case level do
      1 -> 1..10
      2 -> 1..100
      3 -> 1..1000
      _ -> IO.puts("Invalid Level")
        run()
    end
  end
end
