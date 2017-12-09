defmodule Advent.Day04 do
  @input "lib/day04_input"

  def solve_1, do: count_valid(@input, &duplicate?/1)
  def solve_2, do: count_valid(@input, &anagram?/1)

  def count_valid(input, method) do
    File.stream!(input)
    |> Enum.count(method)
  end

  def duplicate?(passphrase) do
    components = String.split(passphrase)
    length(components) == MapSet.new(components) |> MapSet.size()
  end

  def anagram?(passphrase) do
    components =
      for word <- String.split(passphrase),
          sorted = String.graphemes(word) |> Enum.sort(),
          do: sorted

    length(components) == MapSet.new(components) |> MapSet.size()
  end
end
