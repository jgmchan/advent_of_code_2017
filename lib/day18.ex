defmodule Advent.Day18 do
  @input "inputs/day18_input"

  def solve_1 do
    File.read!(@input)
    |> part_1()
  end

  def solve_2 do
    File.read!(@input)
    |> part_2()
  end

  def part_1(input) do
    execute(%{registers: %{}, current: 0, played: nil, recovered: nil}, parse(input))
  end

  def part_2(input) do
    process_0 = %{
      registers: %{p: 0},
      current: 0,
      mailbox: [],
      sent: [],
      receiving: false,
      send_count: 0
    }

    process_1 = %{
      registers: %{p: 1},
      current: 0,
      mailbox: [],
      sent: [],
      receiving: false,
      send_count: 0
    }

    parallel_execute({process_0, process_1}, parse(input))
  end

  def parallel_execute({%{current: nil}, %{current: nil}} = state, _), do: state

  def parallel_execute(
        {%{receiving: true}, %{receiving: true}} = state,
        _
      ),
      do: state

  def parallel_execute({%{receiving: true}, %{current: nil}} = state, _), do: state
  def parallel_execute({%{current: nil}, %{receiving: true}} = state, _), do: state

  def parallel_execute({%{current: current} = process_0, process_1}, instructions)
      when current not in 0..tuple_size(instructions),
      do: {%{process_0 | current: nil}, process_1}

  def parallel_execute({process_0, %{current: current} = process_1}, instructions)
      when current not in 0..tuple_size(instructions),
      do: {process_0, %{process_1 | current: nil}}

  def parallel_execute(
        {process_0 = %{current: current0}, process_1 = %{current: current1}},
        instructions
      ) do
    process_0 = run(process_0, elem(instructions, current0))

    process_1 = run(process_1, elem(instructions, current1))

    {process_1, process_0} = broker_messages({process_1, process_0})

    broker_messages({process_0, process_1})
    |> parallel_execute(instructions)
  end

  def broker_messages({%{sent: []} = sender, receiver}), do: {sender, receiver}

  def broker_messages({%{sent: [sent | rest]} = sender, %{mailbox: mailbox} = receiver}),
    do: {%{sender | sent: rest}, %{receiver | mailbox: mailbox ++ [sent]}}

  def execute(instructions) when is_tuple(instructions),
    do: execute(%{registers: %{}, current: 0, played: nil, recovered: nil}, instructions)

  def execute(state = %{recovered: recovered}, _)
      when not is_nil(recovered),
      do: state

  def execute(state = %{current: current}, instructions)
      when current not in 0..tuple_size(instructions),
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

  def run(state = %{registers: registers}, {:add, [register, value]}) do
    value = resolve_value(value, registers)

    %{state | registers: Map.update(registers, register, value, &(&1 + value))}
    |> Map.update!(:current, &(&1 + 1))
  end

  def run(state = %{registers: registers}, {:mul, [register, value]}) do
    value = resolve_value(value, registers)

    %{state | registers: Map.update(registers, register, 0, &(&1 * value))}
    |> Map.update!(:current, &(&1 + 1))
  end

  def run(state = %{registers: registers}, {:mod, [register, value]}) do
    value = resolve_value(value, registers)

    %{state | registers: Map.update(registers, register, 0, &rem(&1, value))}
    |> Map.update!(:current, &(&1 + 1))
  end

  def run(state = %{registers: registers}, {:jgz, [register, value]})
      when is_atom(register) do
    number = Map.get(registers, register, 0)
    run(state, {:jgz, [number, value]})
  end

  def run(state = %{registers: registers, current: current}, {:jgz, [number, value]})
      when is_integer(number) do
    value = resolve_value(value, registers)

    if number > 0,
      do: %{state | current: current + value},
      else: %{state | current: current + 1}
  end

  def run(state = %{registers: registers, sent: sent, send_count: count}, {:snd, [register]}) do
    %{state | sent: sent ++ [Map.get(registers, register, 0)], send_count: count + 1}
    |> Map.update!(:current, &(&1 + 1))
  end

  # PART 1
  def run(state = %{registers: registers, played: _}, {:snd, [register]}) do
    %{state | played: Map.get(registers, register, 0)}
    |> Map.update!(:current, &(&1 + 1))
  end

  def run(state = %{mailbox: []}, {:rcv, [_register]}) do
    %{state | receiving: true}
  end

  def run(state = %{registers: registers, mailbox: [value | rest]}, {:rcv, [register]}) do
    %{state | registers: Map.put(registers, register, value), mailbox: rest, receiving: false}
    |> Map.update!(:current, &(&1 + 1))
  end

  # PART 1
  def run(state = %{registers: registers, played: played}, {:rcv, [register]}) do
    if(
      Map.get(registers, register, 0) != 0,
      do: %{state | recovered: played},
      else: state
    )
    |> Map.update!(:current, &(&1 + 1))
  end
end
