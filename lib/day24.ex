defmodule Advent.Day24 do
  @input "inputs/day24_input"

  def solve_1 do
    File.read!(@input)
    |> part_1()
  end

  def solve_2 do
    File.read!(@input)
    |> part_2()
  end

  def part_1(input) do
    input |> parse |> find_strongest(0)
  end

  def part_2(input) do
    input |> parse |> find_longest(0) |> Map.get(:strength)
  end

  def parse(input) do
    input
    |> String.trim()
    |> String.split("\n", trim: true)
    |> Enum.map(fn x ->
      String.split(x, "/") |> Enum.map(&String.to_integer/1)
    end)
    |> Enum.reduce(%{}, fn component, graph ->
      matches = Map.keys(graph) |> Enum.filter(&matching(component, &1))

      Enum.reduce(matches, graph, fn match, acc ->
        Map.update(acc, match, [component], &(&1 ++ [component]))
      end)
      |> Map.put(component, matches)
    end)
  end

  def matching([a, b], [x, y])
      when a in [x, y] or b in [x, y],
      do: true

  def matching(_, _), do: false

  def find_strongest(graph, pin) do
    Map.keys(graph)
    |> Enum.filter(&(pin in &1))
    |> strongest(0, graph)
  end

  def strongest(tops, pin, graph, max \\ 0)
  def strongest([], _, _, max), do: max

  def strongest([h | t], pin, graph, max) do
    [other_pin] = List.delete(h, pin)

    matches =
      Map.get(graph, h, [])
      |> Enum.filter(fn component -> other_pin in component end)

    max =
      case strongest(matches, other_pin, remove_component(graph, h), 0) + Enum.sum(h) do
        x when x > max -> x
        _ -> max
      end

    strongest(t, pin, graph, max)
  end

  def find_longest(graph, pin) do
    Map.keys(graph)
    |> Enum.filter(&(pin in &1))
    |> longest(0, graph)
  end

  def longest(tops, pin, graph, max \\ %{length: 0, strength: 0})
  def longest([], _, _, max), do: max

  def longest([h | t], pin, graph, max) do
    [other_pin] = List.delete(h, pin)

    matches =
      Map.get(graph, h, [])
      |> Enum.filter(fn component -> other_pin in component end)

    children_length =
      longest(matches, other_pin, remove_component(graph, h), %{length: 0, strength: 0})
      |> Map.update!(:length, &(&1 + 1))
      |> Map.update!(:strength, &(&1 + Enum.sum(h)))

    %{length: m_length, strength: m_strength} = max

    max =
      case children_length do
        %{length: x_length, strength: x_strength} = x
        when x_length > m_length or (x_length == m_length and x_strength > m_strength) ->
          x

        _ ->
          max
      end

    longest(t, pin, graph, max)
  end

  def remove_component(graph, component) do
    graph
    |> Map.delete(component)
    |> Enum.map(fn {k, v} -> {k, List.delete(v, component)} end)
    |> Enum.into(%{})
  end
end
