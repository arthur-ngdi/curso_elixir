defmodule FizzBuzz do

  def build(file_name) do
    file_name
    |> File.read()
    |> handle_file()
  end

  defp handle_file({:ok, result}) do
    result=
      result
      |>String.split(",")
      |>Enum.map(&convert_to_integer/1)
    {:ok, result}
  end

  defp handle_file({:error, reason}), do: {:error, "Error Reading this file: #{reason}"}

  defp convert_to_integer(elem) do
    elem
    |>String.to_integer()
    |>evaluate()
  end

  defp evaluate(number) when rem(number, 15) == 0, do: :fizzbuzz
  defp evaluate(number) when rem(number, 3) == 0, do: :fizz
  defp evaluate(number) when rem(number, 5) == 0, do: :buzz
  defp evaluate(number), do: number


end
