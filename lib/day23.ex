defmodule Advent.Day23 do
  @input "inputs/day23_input"

  def solve_1 do
    File.read!(@input)
    |> part_1()
  end

  def solve_2 do
    part_2()
  end

  def part_1(input) do
    execute(%{registers: %{}, current: 0, mul_count: 0}, parse(input))
  end

  def part_2() do
    # Input Pseudo Code
    #
    # for b = 106700, b + 17, b != 123700 {
    #   f = 1
    #   for (d=2, d++, d != b) {
    #     for (e=2, e++, e != b) {
    #       if ((d * e) == b) {
    #         f = 0
    #       }
    #     }
    #   }
    #
    #   if f == 0 {
    #     h++
    #   }
    # }
    #
    # Calculate the number of non-primes between 106700 and 123700
    # incremented by steps of 17
    Stream.iterate(106_700, &(&1 + 17))
    |> Stream.take_while(&(&1 <= 123_700))
    |> Enum.count(&not_prime_number/1)
  end

  def not_prime_number(number) do
    Enum.any?(2..div(number, 2), fn x -> rem(number, x) == 0 end)
  end

  def execute(instructions) when is_tuple(instructions),
    do: execute(%{registers: %{}, current: 0, mul_count: 0}, instructions)

  def execute(state = %{current: current}, instructions)
      when current not in 0..(tuple_size(instructions) - 1),
      do: state

  def execute(state = %{current: current}, instructions) do
    instruction = elem(instructions, current)

    state
    |> run(instruction)
    |> execute(instructions)
  end

  def parse(input) do
    input
    |> String.trim()
    |> String.split("\n", trim: true)
    |> Enum.map(&convert/1)
    |> List.to_tuple()
  end

  defp convert(instruction) do
    [operator | args] = String.split(instruction)
    args = Enum.map(args, fn op -> convert_operand(op) end)
    {String.to_atom(operator), args}
  end

  defp convert_operand(operand) do
    if hd(to_charlist(operand)) in ?a..?z,
      do: String.to_atom(operand),
      else: String.to_integer(operand)
  end

  defp resolve_value(value, _) when is_integer(value), do: value

  defp resolve_value(register, registers) when is_atom(register) do
    Map.get(registers, register, 0)
  end

  def run(state = %{current: nil}, _), do: state

  def run(state = %{registers: registers}, {:set, [register, value]}) do
    value = resolve_value(value, registers)

    %{state | registers: Map.put(registers, register, value)}
    |> Map.update!(:current, &(&1 + 1))
  end

  def run(state = %{registers: registers}, {:sub, [register, value]}) do
    value = resolve_value(value, registers)

    %{state | registers: Map.update(registers, register, -value, &(&1 - value))}
    |> Map.update!(:current, &(&1 + 1))
  end

  def run(state = %{registers: registers, mul_count: mul_count}, {:mul, [register, value]}) do
    value = resolve_value(value, registers)

    %{
      state
      | registers: Map.update(registers, register, 0, &(&1 * value)),
        mul_count: mul_count + 1
    }
    |> Map.update!(:current, &(&1 + 1))
  end

  def run(state = %{registers: registers}, {:jnz, [register, value]})
      when is_atom(register) do
    number = Map.get(registers, register, 0)
    run(state, {:jnz, [number, value]})
  end

  def run(state = %{registers: registers, current: current}, {:jnz, [number, value]})
      when is_integer(number) do
    value = resolve_value(value, registers)

    if number != 0,
      do: %{state | current: current + value},
      else: %{state | current: current + 1}
  end
end
