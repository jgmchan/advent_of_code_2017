defmodule Advent.Day17 do
  @input 382
  @times_1 2017
  @times_2 50_000_000

  def solve_1 do
    part_1(@input, @times_1)
  end

  def solve_2 do
    part_2(@input, @times_2)
  end

  def part_1(step_size, times) do
    {buffer, index} = do_steps({[0], 0}, step_size, times, &step/3)
    Enum.at(buffer, rem(index + 1, length(buffer)))
  end

  def part_2(step_size, times) do
    {value, _} = do_steps({nil, 0}, step_size, times, &step2/3)
    value
  end

  def do_steps(state, _, times, count \\ 1, step_type)
  def do_steps(state, _, times, count, _) when times + 1 == count, do: state

  def do_steps(state, step_size, times, count, step_type) do
    step_type.(state, count, step_size)
    |> do_steps(step_size, times, count + 1, step_type)
  end

  def step({buffer, index}, value, step_size) do
    new_index = rem(index + step_size, length(buffer)) + 1
    new_buffer = List.insert_at(buffer, new_index, value)
    {new_buffer, new_index}
  end

  def step2({buffer_value, index}, value, step_size) do
    new_index = rem(index + step_size, value) + 1
    buffer_value = if new_index == 1, do: value, else: buffer_value
    {buffer_value, new_index}
  end
end
