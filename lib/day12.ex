defmodule Advent.Day12 do
  @input "lib/day12_input"

  def solve_1 do
    File.read!(@input)
    |> part_1()
  end

  def solve_2 do
    File.read!(@input)
    |> part_2()
  end

  def part_1(input, root \\ 0) do
    build_graph(input)
    |> search_group(root)
    |> Enum.count()
  end

  def part_2(input) do
    build_graph(input)
    |> count_groups()
  end

  def count_groups(graph, count \\ 0)
  def count_groups(graph, count) when graph == %{}, do: count

  def count_groups(graph, count) do
    key = Map.keys(graph) |> List.first()

    group_members = search_group(graph, key)

    new_graph = Map.drop(graph, group_members)
    count_groups(new_graph, count + 1)
  end

  def build_graph(input) do
    for line <- String.split(input, "\n", trim: true),
        [vertex, tail] = String.split(line, " <-> ", trim: true),
        edges = String.split(tail, ", ", trim: true),
        into: %{},
        do: {String.to_integer(vertex), Enum.map(edges, &String.to_integer/1)}
  end

  def search_group(graph, root, members \\ []) do
    Enum.reduce(Map.get(graph, root), members, fn peer, acc ->
      if peer in acc,
        do: acc,
        else: search_group(graph, peer, [peer | acc])
    end)
  end
end
