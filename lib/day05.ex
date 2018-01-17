defmodule Advent.Day05 do
  @input "inputs/day05_input"

  def solve_1 do
    File.stream!(@input)
    |> Stream.map(fn x -> x |> String.trim() |> String.to_integer() end)
    |> part_1
  end

  def solve_2 do
    File.stream!(@input)
    |> Stream.map(fn x -> x |> String.trim() |> String.to_integer() end)
    |> part_2
  end

  def part_1(input) do
    get_count(input, fn c -> c + 1 end, :pdict)
  end

  def part_2(input) do
    get_count(
      input,
      fn
        c when c >= 3 -> c - 1
        c -> c + 1
      end,
      :pdict
    )
  end

  def get_count(input, fun, :ets) do
    input
    |> ets_table()
    |> ets_jumps(fun)
  end

  # Using the Process dictionary is about 4 times faster than ETS
  # or Maps
  def get_count(input, fun, :pdict) do
    input
    |> pdict()

    pdict_jumps(fun)
  end

  def get_count(input, fun, :map) do
    input
    |> map_of()
    |> map_jumps(fun)
  end

  def ets_jumps(table, fun, index \\ 0, count \\ 0) do
    case :ets.lookup(table, index) do
      [] ->
        count

      [{index, value}] ->
        :ets.insert(table, {index, fun.(value)})
        ets_jumps(table, fun, index + value, count + 1)
    end
  end

  def pdict_jumps(fun, index \\ 0, count \\ 0) do
    case Process.get(index) do
      nil ->
        count

      value ->
        Process.put(index, fun.(value))
        pdict_jumps(fun, index + value, count + 1)
    end
  end

  def map_jumps(map, fun, index \\ 0, count \\ 0) do
    case Map.get(map, index) do
      nil ->
        count

      value ->
        Map.update!(map, index, fun)
        |> map_jumps(fun, value + index, count + 1)
    end
  end

  def ets_table(input) do
    input
    |> Stream.with_index()
    |> Enum.reduce(:ets.new(:foo, []), fn {value, index}, acc ->
      :ets.insert(acc, {index, value})
      acc
    end)
  end

  def pdict(input) do
    input
    |> Stream.with_index()
    |> Enum.each(fn {value, index} ->
      Process.put(index, value)
    end)
  end

  def map_of(input) do
    input
    |> Stream.with_index()
    |> Enum.into(%{}, fn {value, index} ->
      {index, value}
    end)
  end
end
