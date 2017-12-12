# ANSWER PART 2: 596
defmodule Advent.Day07 do
  @input "lib/day07_input"

  def solve_2 do
    bottom = solve_1()

    File.stream!(@input)
    |> Stream.map(&String.trim/1)
    |> Enum.map(&convert/1)
    |> Enum.into(%{})
    |> find_wrong_program(bottom)
  end

  def solve_1 do
    File.stream!(@input)
    |> Stream.map(&String.trim/1)
    |> Enum.map(&convert/1)
    |> Enum.into(%{})
    |> find_root
  end

  def convert(input) do
    case String.split(input, " ", parts: 4) do
      [name, weight, _, children] ->
        children = children |> String.split(", ")
        {name, {transform(weight), children}}

      [name, weight] ->
        {name, {transform(weight), []}}
    end
  end

  def transform(weight) do
    weight
    |> String.trim_leading("(")
    |> String.trim_trailing(")")
    |> String.to_integer()
  end

  def find_root(graph) do
    [{name, _}] = Enum.take(graph, 1)
    find_root(graph, name)
  end

  def find_root(graph, bottom) do
    case Enum.find(graph, fn {_, {_, children}} -> bottom in children end) do
      {parent, _} -> find_root(graph, parent)
      nil -> bottom
    end
  end

  # A wrong program is when it is different from it's siblings, and it's children are balanced

  def find_wrong_program(input, root, unique \\ false, unique_weight \\ 0) do
    {weight, children} = Map.get(input, root)

    {balanced?, unique_children, majority_weight} = is_balanced?(input, children)

    cond do
      balanced? and unique ->
        {root, weight - abs(majority_weight * length(children) + weight - unique_weight)}

      true ->
        Enum.map(unique_children, fn child ->
          find_wrong_program(input, child, true, majority_weight)
        end)
    end
  end

  def child_weight(input, child) do
    {weight, children} = Map.get(input, child)
    total_weight(input, child, weight, children)
  end

  def total_weight(_input, _name, weight, []), do: weight

  def total_weight(input, _name, weight, children) do
    Enum.reduce(children, weight, fn child, acc ->
      {child_weight, grand_children} = Map.get(input, child)
      acc + total_weight(input, child, child_weight, grand_children)
    end)
  end

  def is_balanced?(input, children) do
    children_weights =
      Enum.map(children, fn child ->
        child_weight(input, child)
      end)

    weight_counts =
      Enum.reduce(children_weights, %{}, fn child, acc ->
        Map.update(acc, child, 1, fn curr -> curr + 1 end)
      end)

    case Enum.count(weight_counts) do
      1 ->
        {true, [], Map.keys(weight_counts) |> List.first()}

      _ ->
        {majority, _} = Enum.max_by(weight_counts, fn {_weight, num} -> num end)
        children_pairs = Enum.zip(children, children_weights)

        unique_children =
          for child <- children_pairs, {name, weight} = child, weight != majority, do: name

        {false, unique_children, majority}
    end
  end
end
