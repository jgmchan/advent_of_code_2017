defmodule Advent.Day21 do
  @rules "inputs/day21_input"
  @input_pattern ".#./..#/###"

  def solve_1 do
    File.stream!(@rules)
    |> part_1(5)
  end

  def solve_2 do
    File.stream!(@rules)
    |> part_1(18)
  end

  def part_1(rules, iteration) do
    rules = parse(rules)

    input = convert(@input_pattern)

    enhance(input, rules, iteration)
    |> List.flatten()
    |> Enum.sum()
  end

  def enhance(pattern, rules, count \\ 1)
  def enhance(pattern, _, 0), do: pattern

  def enhance(pattern, rules, count) do
    pattern
    |> divide()
    |> Enum.map(fn pattern ->
      Map.fetch!(rules, pattern)
    end)
    |> join()
    |> enhance(rules, count - 1)
  end

  def parse(input) do
    input
    |> Enum.map(fn line ->
      line
      |> String.trim()
      |> String.split(" => ")
      |> Enum.map(&convert/1)
      |> List.to_tuple()
    end)
    |> expand_rules()
    |> Enum.into(%{})
  end

  def expand_rules(rules) do
    permutations = [
      & &1,
      &flip_horizontal/1,
      &flip_vertical/1,
      &rotate_right/1,
      &rotate_left/1,
      &transpose/1,
      &rotate_180/1,
      &reverse_transpose/1
    ]

    rules
    |> Enum.flat_map(fn {pattern, output} ->
      Enum.map(permutations, fn permutate ->
        {permutate.(pattern), output}
      end)
    end)
  end

  def convert(string) do
    for pattern <- String.split(string, "/") do
      String.codepoints(pattern)
      |> Enum.map(fn point ->
        case point do
          "#" -> 1
          "." -> 0
        end
      end)
    end
  end

  def divide(pattern) when rem(length(pattern), 2) == 0, do: divide(pattern, 2)
  def divide(pattern) when rem(length(pattern), 3) == 0, do: divide(pattern, 3)

  def divide(pattern, size) do
    pattern
    |> Enum.chunk_every(size)
    |> Enum.flat_map(fn chunk ->
      Enum.map(chunk, fn row -> Enum.chunk_every(row, size) end)
      |> Enum.zip()
      |> Enum.map(&Tuple.to_list/1)
    end)
  end

  def join(patterns) do
    size = length(patterns) |> :math.sqrt() |> trunc()

    patterns
    |> Enum.chunk_every(size)
    |> Enum.flat_map(fn chunk ->
      Enum.reduce(chunk, fn square, acc ->
        for {x, y} <- Enum.zip(acc, square) do
          x ++ y
        end
      end)
    end)
  end

  def flip_horizontal(x), do: Enum.map(x, &Enum.reverse/1)

  def flip_vertical(x), do: Enum.reverse(x)

  def rotate_right(x), do: x |> transpose() |> flip_horizontal()

  def rotate_left(x), do: x |> transpose() |> flip_vertical()

  def rotate_180(x), do: x |> rotate_right() |> rotate_right()

  def reverse_transpose(x), do: x |> rotate_left |> flip_horizontal

  def transpose([[] | _]), do: []
  def transpose(x), do: [Enum.map(x, &hd/1) | transpose(Enum.map(x, &tl/1))]
end
