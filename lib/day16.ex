defmodule Advent.Day16 do
  @start ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p"]
  @input "inputs/day16_input"
  @times 1_000_000_000

  def solve_1 do
    part_1(@start, File.read!(@input))
  end

  def solve_2 do
    part_2(@start, File.read!(@input))
  end

  def part_1(start, input) do
    moves = parse(input)
    dance(start, moves, 1)
  end

  def part_2(start, input) do
    moves = parse(input)
    dance(start, moves, rem(@times, detect_cycle(start, moves)))
  end

  def detect_cycle(line, moves, seen \\ %{}, times \\ 0) do
    case Map.get(seen, line) do
      nil ->
        new_line = dance(line, moves)
        seen = Map.put(seen, line, new_line)
        detect_cycle(new_line, moves, seen, times + 1)

      _ ->
        times
    end
  end

  def dance(line, moves, times \\ 1)
  def dance(line, _, times) when times <= 0, do: line

  def dance(line, moves, times) do
    line = Enum.reduce(moves, line, &move(&2, &1))
    dance(line, moves, times - 1)
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

  def move(start, {:s, [pos]}) do
    {head, tail} = Enum.split(start, -rem(pos, length(start)))
    tail ++ head
  end

  def move(start, {:x, [index_1, index_2]}), do: swap(start, index_1, index_2)

  def move(start, {:p, [prog_1, prog_2]}) do
    index_1 = Enum.find_index(start, &(&1 == prog_1))
    index_2 = Enum.find_index(start, &(&1 == prog_2))
    swap(start, index_1, index_2)
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
