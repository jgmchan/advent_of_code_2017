defmodule Advent.Day16 do
  @start ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p"]
  @input "inputs/day16_input"
  @times 1_000_000_000

  def solve_1 do
    do_dance(@start, File.read!(@input), 1)
  end

  def solve_2 do
    do_dance(@start, File.read!(@input), @times)
  end

  def do_dance(programs, input, count) do
    dance_moves =
      parse(input)
      |> compile_dance(programs)

    dance(programs, dance_moves, count)
  end

  def compile_dance(instructions, programs) do
    positions = Enum.to_list(0..(length(programs) - 1))
    substitutions = Enum.reduce(programs, %{}, &Map.put(&2, &1, &1))
    Enum.reduce(instructions, {positions, substitutions}, &full_dance_mapping/2)
  end

  # Count is 1, return the dance moves applied to the original programs
  def dance(programs, dance_moves, 1) do
    apply_dance(programs, dance_moves)
  end

  # Even number of dances, similar to f(x * x)
  def dance(programs, dance_moves, count) when rem(count, 2) == 0 do
    dance(programs, double(dance_moves), div(count, 2))
  end

  # Odd number of dances, similar to x * f(x * x)
  def dance(programs, dance_moves, count) do
    dance(programs, double(dance_moves), div(count, 2))
    |> apply_dance(dance_moves)
  end

  # Apply the dance_moves to the programs
  defp apply_dance(programs, {positions, substitutions}) do
    positions
    |> Enum.map(&Map.get(substitutions, Enum.at(programs, &1)))
  end

  # Doubles the dance moves on itself, this makes each
  # application of the dance moves to 2**n times
  defp double({positions, substitutions}) do
    positions =
      positions
      |> Enum.map(&Enum.at(positions, &1))

    substitutions =
      substitutions
      |> Enum.reduce(%{}, fn {k, v}, acc -> Map.put(acc, k, substitutions[v]) end)

    {positions, substitutions}
  end

  def parse(input) do
    input
    |> String.trim()
    |> String.split(",", trim: true)
    |> Enum.map(fn instruction ->
      {move, tail} = String.next_codepoint(instruction)

      args =
        String.split(tail, "/", trim: true)
        |> Enum.map(fn x ->
          if String.match?(x, ~r/^\d+$/), do: String.to_integer(x), else: x
        end)

      {String.to_atom(move), args}
    end)
  end

  def full_dance_mapping({:s, [pos]}, {positions, substitutions}) do
    {shift(positions, pos), substitutions}
  end

  def full_dance_mapping({:x, [index_1, index_2]}, {positions, substitutions}) do
    {swap(positions, index_1, index_2), substitutions}
  end

  def full_dance_mapping({:p, [prog_1, prog_2]}, {positions, substitutions}) do
    substitutions =
      substitutions
      |> Enum.map(fn
        {k, ^prog_1} -> {k, prog_2}
        {k, ^prog_2} -> {k, prog_1}
        kv -> kv
      end)
      |> Enum.into(%{})

    {positions, substitutions}
  end

  def shift(list, pos) do
    {head, tail} = Enum.split(list, -rem(pos, length(list)))
    tail ++ head
  end

  def swap(list, prog_1, prog_2) when is_binary(prog_1) and is_binary(prog_2) do
    index_1 = Enum.find_index(list, &(&1 == prog_1))
    index_2 = Enum.find_index(list, &(&1 == prog_2))
    swap(list, index_1, index_2)
  end

  def swap(list, index_1, index_2) when index_1 > index_2 do
    swap(list, index_2, index_1)
  end

  def swap(list, index_1, index_2) when index_1 < index_2 do
    difference = index_2 - index_1 + 1

    list
    |> Enum.reverse_slice(index_1, difference)
    |> Enum.reverse_slice(index_1 + 1, difference - 2)
  end
end
