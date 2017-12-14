defmodule Advent.Day11 do
  @input "inputs/day11_input"

  def solve_1 do
    File.read!(@input)
    |> String.trim()
    |> String.split(",")
    |> part_1
  end

  def solve_2 do
    File.read!(@input)
    |> String.trim()
    |> String.split(",")
    |> part_2
  end

  def part_1(input) do
    Enum.reduce(input, {0, 0, 0}, &move(&2, &1)) |> cube_distance
  end

  def part_2(input) do
    Enum.reduce(input, {{0, 0, 0}, 0}, fn direction, {coordinate, max} ->
      new_coordinate = coordinate |> move(direction)

      distance = cube_distance(new_coordinate)

      max = if distance > max, do: distance, else: max

      {new_coordinate, max}
    end)
  end

  def move({x, y, z}, "n"), do: {x + 1, y, z - 1}
  def move({x, y, z}, "ne"), do: {x + 1, y - 1, z}
  def move({x, y, z}, "se"), do: {x, y - 1, z + 1}
  def move({x, y, z}, "s"), do: {x - 1, y, z + 1}
  def move({x, y, z}, "sw"), do: {x - 1, y + 1, z}
  def move({x, y, z}, "nw"), do: {x, y + 1, z - 1}

  def cube_distance({from_x, from_y, from_z}, {to_x, to_y, to_z} \\ {0, 0, 0}) do
    div(abs(from_x - to_x) + abs(from_y - to_y) + abs(from_z - to_z), 2)
  end
end
