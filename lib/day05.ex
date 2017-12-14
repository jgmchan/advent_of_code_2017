defmodule Advent.Day05 do
  @input "inputs/day05_input"

  def solve_1 do
    File.stream!(@input)
    |> Stream.map(fn x -> x |> String.trim() |> String.to_integer() end)
    |> get_count(&increase_1/1)
  end

  def solve_2 do
    File.stream!(@input)
    |> Stream.map(fn x -> x |> String.trim() |> String.to_integer() end)
    |> get_count(&decrease_1/1)
  end

  def part_1(input) do
    get_count(input, &increase_1/1)
  end

  def part_2(input) do
    get_count(input, &decrease_1/1)
  end

  def get_count(input, fun) do
    input
    |> map_of()
    |> jumps(fun)
  end

  defp increase_1(current_value) do
    {current_value, current_value + 1}
  end

  defp decrease_1(current_value) when current_value >= 3 do
    {current_value, current_value - 1}
  end

  defp decrease_1(current_value) do
    {current_value, current_value + 1}
  end

  def jumps(map, fun, index \\ 0, count \\ 0) do
    if Map.has_key?(map, index) do
      {current, map} = Map.get_and_update(map, index, fun)

      jumps(map, fun, current + index, count + 1)
    else
      count
    end
  end

  def map_of(input) do
    input
    |> Stream.with_index()
    |> Enum.into(%{}, fn {value, index} ->
         {index, value}
       end)
  end
end
