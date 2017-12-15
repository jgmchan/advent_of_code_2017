defmodule Advent.Day13 do
  @input "inputs/day13_input"

  def solve_1 do
    File.stream!(@input)
    |> part_1()
  end

  def solve_2 do
    File.stream!(@input)
    |> part_2()
  end

  def parse(input) do
    for line <- input,
        pair = line |> String.trim() |> String.split(": ", trim: true),
        [level, depth] = Enum.map(pair, &String.to_integer/1) do
      {level, depth}
    end
  end

  def part_1(input) do
    parse(input)
    |> sum_severity()
    |> elem(0)
  end

  def part_2(input) do
    parse(input)
    |> Enum.sort_by(fn {_, v} -> v end)
    |> find_delay()
  end

  def find_delay(input, delay \\ 0) do
    case Enum.any?(input, fn firewall -> hit?(firewall, delay) end) do
      true -> find_delay(input, delay + 1)
      false -> delay
    end
  end

  def hit?({level, depth}, delay) do
    severity(level, depth, delay) |> elem(0)
  end

  def severity(level, depth, delay) do
    if rem(level + delay, depth * 2 - 2) == 0, do: {true, level * depth}, else: {false, 0}
  end

  def sum_severity(input, delay \\ 0) do
    Enum.reduce(input, {0, []}, fn {level, depth}, {sum, hit_level} = acc ->
      {hit, severity} = severity(level, depth, delay)
      if hit, do: {sum + severity, hit_level ++ [level]}, else: acc
    end)
  end
end
