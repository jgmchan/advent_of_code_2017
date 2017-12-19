defmodule Advent.Day14 do
  @input "wenycdww"

  def solve_1 do
    part_1(@input)
  end

  def solve_2 do
    part_2(@input)
  end

  def part_1(input) do
    bitmap(input)
    |> List.flatten()
    |> Enum.sum()
  end

  def part_2(input) do
    bitmap(input)
    |> bitmap_to_mapset
    |> count_regions
  end

  def count_regions(mapset, count \\ 0) do
    if Enum.empty?(mapset) do
      count
    else
      [first] = Enum.take(mapset, 1)
      region = find_neighbours(first, mapset, MapSet.new([first]))
      mapset = MapSet.difference(mapset, region)
      count_regions(mapset, count + 1)
    end
  end

  def find_neighbours({column, row}, squares, region) do
    [{-1, 0}, {1, 0}, {0, -1}, {0, 1}]
    |> Enum.map(fn {x, y} -> {column + x, row + y} end)
    |> Enum.filter(fn square ->
      MapSet.member?(squares, square) and not MapSet.member?(region, square)
    end)
    |> Enum.reduce(region, fn next, acc ->
      find_neighbours(next, MapSet.delete(squares, next), MapSet.put(acc, next))
    end)
  end

  def bitmap_to_mapset(bitmap) do
    for {row, row_index} <- Enum.with_index(bitmap),
        {column, column_index} <- Enum.with_index(row),
        column != 0,
        do: {column_index, row_index},
        into: MapSet.new()
  end

  def bitmap(input) do
    input
    |> row_hashes
    |> Enum.map(fn hash ->
      hash
      |> convert_to_integer()
      |> Enum.flat_map(&binary_array/1)
    end)
  end

  def binary_array(integer) do
    for(<<bin::1 <- :binary.encode_unsigned(integer)>>, do: bin)
    |> Enum.take(-4)
  end

  def row_hashes(input) do
    for row <- 0..127,
        row_name = input <> "-#{row}",
        hash = Advent.Day10.get_knot_hash(row_name),
        do: hash
  end

  def convert_to_integer(string, output \\ [])
  def convert_to_integer(<<>>, output), do: output

  def convert_to_integer(<<head::utf8, tail::binary>>, output) do
    convert_to_integer(tail, output ++ [hex_to_integer(<<head>>)])
  end

  def hex_to_integer("a"), do: 10
  def hex_to_integer("b"), do: 11
  def hex_to_integer("c"), do: 12
  def hex_to_integer("d"), do: 13
  def hex_to_integer("e"), do: 14
  def hex_to_integer("f"), do: 15
  def hex_to_integer(x), do: String.to_integer(x)
end
