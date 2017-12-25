defmodule Advent.Day19 do
  @input "inputs/day19_input"

  def solve_1 do
    File.read!(@input)
    |> part_1()
  end

  def solve_2 do
    File.read!(@input)
    |> part_2()
  end

  def part_1(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn x -> String.to_charlist(x) end)
    |> follow()
  end

  def part_2(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn x -> String.to_charlist(x) end)
    |> follow()
  end

  def follow(diagram) do
    start =
      diagram
      |> List.first()
      |> Enum.find_index(&(&1 == ?|))

    follow(diagram, {start, 0}, {start, -1}, '', 0)
  end

  def follow(diagram, current, previous, letters, count) do
    current_symbol = symbol(diagram, current)

    case current_symbol do
      ?\s ->
        {letters, count}

      _ ->
        letters =
          if current_symbol in ?A..?Z,
            do: letters ++ [current_symbol],
            else: letters

        next_square = next_square(diagram, previous, current)

        follow(diagram, next_square, current, letters, count + 1)
    end
  end

  def next_square(diagram, previous = {prev_x, prev_y}, current = {curr_x, curr_y}) do
    diff_x = curr_x - prev_x
    diff_y = curr_y - prev_y

    case symbol(diagram, current) do
      x when x in [?|, ?-] or x in ?A..?Z ->
        {curr_x + diff_x, curr_y + diff_y}

      ?+ ->
        [{0, 1}, {0, -1}, {1, 0}, {-1, 0}]
        |> Enum.map(fn {x, y} -> {curr_x + x, curr_y + y} end)
        |> List.delete(previous)
        |> Enum.find(fn next ->
          next_symbol = symbol(diagram, next)
          not is_nil(next_symbol) and next_symbol != 32
        end)
    end
  end

  def symbol(diagram, {x, y}) do
    height = length(diagram)
    width = diagram |> List.first() |> length()

    if x >= width or y >= height,
      do: nil,
      else: diagram |> Enum.at(y) |> Enum.at(x)
  end
end
