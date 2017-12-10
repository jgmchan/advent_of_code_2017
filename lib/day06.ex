defmodule Advent.Day06 do
  @input [14, 0, 15, 12, 11, 11, 3, 5, 1, 6, 8, 4, 9, 1, 8, 4]

  def solve_2 do
    map = for {x, y} <- Enum.with_index(@input), do: {y, x}, into: %{}
    loop_cycles(map)
  end

  def solve_1 do
    map = for {x, y} <- Enum.with_index(@input), do: {y, x}, into: %{}
    redistribution_cycles(map)
  end

  def loop_cycles(input) do
    {_, [last_state | tail]} = redistribution_cycles(input)

    Enum.find_index(tail, fn x -> x == last_state end) + 1
  end

  def redistribution_cycles(input, states \\ [], cycles \\ 0)

  def redistribution_cycles(input, states, cycles) do
    if input in states do
      states = [input | states]
      {cycles, states}
    else
      states = [input | states]
      {index, count} = Enum.max_by(input, fn {_k, v} -> v end)
      start_index = rem(index + 1, Enum.count(input))

      input
      |> Map.put(index, 0)
      |> balance(start_index, count)
      |> redistribution_cycles(states, cycles + 1)
    end
  end

  def balance(input, _index, 0), do: input

  def balance(input, index, count) do
    size = Enum.count(input)

    {_, input} = Map.get_and_update!(input, index, &{&1, &1 + 1})

    balance(input, rem(index + 1, size), count - 1)
  end
end
