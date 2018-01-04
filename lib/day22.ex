defmodule Advent.Day22 do
  @input "inputs/day22_input"

  def solve_1 do
    File.read!(@input)
    |> part_1(10000)
  end

  def solve_2 do
    File.read!(@input)
    |> part_2(10_000_000)
  end

  def part_1(input, count) do
    map = parse(input)
    start = start_position(map)
    burst(map, start, :north, 0, count, :v1)
  end

  def part_2(input, count) do
    map = parse(input)
    start = start_position(map)
    burst(map, start, :north, 0, count, :v2)
  end

  def burst(map, position, direction, infection_count, count \\ 10000, version \\ :v1)

  def burst(_, _, _, infection_count, 0, _), do: infection_count

  def burst(map, position, direction, infection_count, count, :v1) do
    {pos_state, map} =
      Map.get_and_update(map, position, fn
        :clean -> {:clean, :infected}
        :infected -> {:infected, :clean}
        _ -> {:clean, :infected}
      end)

    {new_direction, infection_count} =
      case pos_state do
        :clean -> {turn(direction, :left), infection_count + 1}
        :infected -> {turn(direction, :right), infection_count}
      end

    burst(map, move(position, new_direction), new_direction, infection_count, count - 1, :v1)
  end

  def burst(map, position, direction, infection_count, count, :v2) do
    {pos_state, map} =
      Map.get_and_update(map, position, fn
        :clean -> {:clean, :weakened}
        :weakened -> {:weakened, :infected}
        :infected -> {:infected, :flagged}
        :flagged -> {:flagged, :clean}
        _ -> {:clean, :weakened}
      end)

    {new_direction, infection_count} =
      case pos_state do
        :clean -> {turn(direction, :left), infection_count}
        :infected -> {turn(direction, :right), infection_count}
        :flagged -> {turn(direction, :opposite), infection_count}
        :weakened -> {direction, infection_count + 1}
      end

    burst(map, move(position, new_direction), new_direction, infection_count, count - 1, :v2)
  end

  def parse(input) do
    for {row, row_index} <- String.split(input, "\n", trim: true) |> Enum.with_index(),
        {codepoint, column_index} <- String.codepoints(row) |> Enum.with_index(),
        into: %{} do
      status =
        case codepoint do
          "." -> :clean
          "#" -> :infected
        end

      {{column_index, row_index}, status}
    end
  end

  def start_position(map) do
    centre_index = div(:math.sqrt(map_size(map)) |> trunc(), 2)
    {centre_index, centre_index}
  end

  def turn(:north, :right), do: :east
  def turn(:east, :right), do: :south
  def turn(:south, :right), do: :west
  def turn(:west, :right), do: :north

  def turn(:north, :left), do: :west
  def turn(:east, :left), do: :north
  def turn(:south, :left), do: :east
  def turn(:west, :left), do: :south

  def turn(:north, :opposite), do: :south
  def turn(:east, :opposite), do: :west
  def turn(:south, :opposite), do: :north
  def turn(:west, :opposite), do: :east

  def move({x, y}, :north), do: {x, y - 1}
  def move({x, y}, :east), do: {x + 1, y}
  def move({x, y}, :south), do: {x, y + 1}
  def move({x, y}, :west), do: {x - 1, y}
end
