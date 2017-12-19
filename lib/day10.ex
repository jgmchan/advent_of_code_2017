defmodule Advent.Day10 do
  @input "130,126,1,11,140,2,255,207,18,254,246,164,29,104,0,224"

  use Bitwise

  def get_knot_hash(input) do
    0..255
    |> part_2(input)
  end

  def solve_1 do
    part_1(
      0..255,
      @input
      |> String.split(",", trim: true)
      |> Enum.map(fn x -> String.to_integer(x) end)
    )
  end

  def solve_2 do
    part_2(0..255, @input)
  end

  def part_1(input, lengths) do
    input
    |> Enum.to_list()
    |> step(lengths)
    |> elem(0)
    |> Enum.take(2)
    |> Enum.reduce(fn x, acc -> x * acc end)
  end

  def part_2(input, lengths) do
    magic_suffix = [17, 31, 73, 47, 23]

    lengths = String.to_charlist(lengths) ++ magic_suffix

    input
    |> Enum.to_list()
    |> sparse_hash(lengths)
    |> dense_hash
    |> to_knot_hash
  end

  def sparse_hash(input, lengths) do
    {output, _, _} =
      Enum.reduce(1..64, {input, 0, 0}, fn _x, {input, current_pos, skip_size} ->
        step(input, lengths, current_pos, skip_size)
      end)

    output
  end

  def dense_hash(input) do
    for chunk <- Enum.chunk_every(input, 16), do: Enum.reduce(chunk, fn x, acc -> x ^^^ acc end)
  end

  def to_knot_hash(input) do
    input |> :binary.list_to_bin() |> Base.encode16(case: :lower)
  end

  def step(input, lengths, current_pos \\ 0, skip_size \\ 0)
  def step(input, [], current_pos, skip_size), do: {input, current_pos, skip_size}

  def step(input, [length | tail], current_pos, skip_size) do
    new_pos = rem(current_pos + (length + skip_size), length(input))

    input
    |> in_circular_list(current_pos, &reverse_section(&1, length))
    |> step(tail, new_pos, skip_size + 1)
  end

  def reverse_section(input, length) do
    {head, tail} = Enum.split(input, length)
    (head |> Enum.reverse()) ++ tail
  end

  def in_circular_list(input, current_pos, fun) do
    switch_list(input, current_pos)
    |> fun.()
    |> switch_list(length(input) - current_pos)
  end

  defp switch_list(input, pos) do
    {head, tail} = Enum.split(input, pos)
    tail ++ head
  end
end
