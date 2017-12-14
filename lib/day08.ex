defmodule Advent.Day08 do
  @input "inputs/day08_input"

  def solve_2 do
    @input |> File.stream!() |> part_2()
  end

  def solve_1 do
    @input |> File.stream!() |> part_1
  end

  def part_1(input) do
    {_peak, registers} = input |> execute_all()

    {_, value} = Enum.max_by(registers, fn {_, value} -> value end)

    value
  end

  def part_2(input) do
    input
    |> execute_all()
    |> elem(1)
  end

  def execute_all(input) do
    input
    |> Stream.map(&parse/1)
    |> Enum.reduce({0, %{}}, fn instruction, {max, acc} ->
         acc = execute_instruction(acc, instruction)

         max =
           case Enum.max_by(acc, fn {_, value} -> value end, fn -> 0 end) do
             {_, value} when value > max -> value
             _ -> max
           end

         {max, acc}
       end)
  end

  def parse(instruction) do
    [register, action, value, _, conditional] = String.split(instruction, " ", parts: 5)
    [left, op, right] = String.split(conditional)

    {
      String.to_atom(register),
      String.to_atom(action),
      String.to_integer(value),
      {String.to_atom(op), String.to_atom(left), String.to_integer(right)}
    }
  end

  def execute_instruction(registers, {register, op, count, conditional}) do
    if condition_passed?(conditional, registers) do
      case op do
        :inc -> Map.update(registers, register, 0 + count, fn current -> current + count end)
        :dec -> Map.update(registers, register, 0 - count, fn current -> current - count end)
      end
    else
      registers
    end
  end

  def condition_passed?({op, left, right}, register) when op in [:<, :>, :==, :!=, :<=, :>=] do
    register_value = Map.get(register, left, 0)
    apply(Kernel, op, [register_value, right])
  end
end
