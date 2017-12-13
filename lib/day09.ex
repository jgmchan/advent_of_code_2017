defmodule Advent.Day09 do
  @input "lib/day09_input"

  def solve_1 do
    @input |> File.read!() |> part_1()
  end

  def solve_2 do
    @input |> File.read!() |> part_2()
  end

  def garbage_count(input), do: parse(input) |> Map.get(:garbage_count)

  def score(input) do
    parse(input)
    |> Map.get(:stack)
    |> Enum.reduce(0, fn
         {:group_start, count}, acc -> count + acc
         _, acc -> acc
       end)
  end

  def parse(input) when is_binary(input) do
    input |> String.to_charlist() |> parse(%{stack: [], garbage_count: 0})
  end

  def parse([], state), do: state

  def parse([?! | [_h | tail]], state), do: parse(tail, state)

  def parse([?< | tail], %{stack: [{:group_start, _} | _] = stack} = state),
    do: parse(tail, %{state | stack: [{:garbage_start} | stack]})

  def parse([?< | tail], %{stack: [{:group_end, _} | _] = stack} = state),
    do: parse(tail, %{state | stack: [{:garbage_start} | stack]})

  def parse([?< | tail], %{stack: []} = state),
    do: parse(tail, %{state | stack: [{:garbage_start}]})

  def parse([?> | tail], %{stack: [{:garbage_start} | popped_stack]} = state),
    do: parse(tail, %{state | stack: popped_stack})

  def parse([?{ | tail], %{stack: [{:group_end, level} | _] = stack} = state),
    do: parse(tail, %{state | stack: [{:group_start, level} | stack]})

  def parse([?{ | tail], %{stack: [{:group_start, level} | _] = stack} = state),
    do: parse(tail, %{state | stack: [{:group_start, level + 1} | stack]})

  def parse([?{ | tail], %{stack: []} = state),
    do: parse(tail, %{state | stack: [{:group_start, 1}]})

  def parse([?} | tail], %{stack: [{:group_start, level} | _] = stack} = state),
    do: parse(tail, %{state | stack: [{:group_end, level} | stack]})

  def parse([?} | tail], %{stack: [{:group_end, level} | _] = stack} = state),
    do: parse(tail, %{state | stack: [{:group_end, level - 1} | stack]})

  def parse(
        [_ | tail],
        %{stack: [{:garbage_start} | _] = stack, garbage_count: garbage_count} = state
      ),
      do: parse(tail, %{state | stack: stack, garbage_count: garbage_count + 1})

  def parse([_ | tail], %{stack: _} = state), do: parse(tail, state)

  def part_1(input) do
    input |> score()
  end

  def part_2(input) do
    input |> garbage_count()
  end
end
