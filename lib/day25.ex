defmodule Advent.Day25 do
  @input "inputs/day25_input"

  def solve_1 do
    File.read!(@input) |> part_1()
  end

  def part_1(blueprint) do
    initial = blueprint |> parse()

    run_machine(%{0 => 0}, initial.instructions, initial.start, 0, initial.diagnostic_step)
    |> Map.values()
    |> Enum.sum()
  end

  def extract(string, pattern), do: Regex.run(pattern, string, capture: :all_but_first) |> hd()

  def parse_paragraph("Begin" <> _ = paragraph, state) do
    Map.merge(state, %{
      start: extract(paragraph, ~r/Begin in state (.)/) |> String.to_atom(),
      diagnostic_step:
        extract(paragraph, ~r/Perform a diagnostic checksum after (\d+) steps./)
        |> String.to_integer()
    })
  end

  def parse_paragraph("In state " <> _ = paragraph, state) do
    current_state = extract(paragraph, ~r/In state (.):/) |> String.to_atom()

    instructions =
      [0, 1]
      |> Enum.map(&parse_instruction(paragraph, current_state, &1))
      |> Enum.reduce(%{}, &Map.merge/2)

    Map.update(state, :instructions, instructions, &Map.merge(&1, instructions))
  end

  def parse_instruction(paragraph, state, value) do
    %{
      {state, value} =>
        {
          extract(paragraph, ~r/value is #{value}.*Write the value (\d)\./sU)
          |> String.to_integer(),
          extract(paragraph, ~r/value is #{value}.*slot to the (\w+)\./sU) |> String.to_atom(),
          extract(paragraph, ~r/value is #{value}.*with state (\w)\./sU) |> String.to_atom()
        }
    }
  end

  def parse(blueprint) do
    blueprint
    |> String.trim()
    |> String.split("\n\n", trim: true)
    |> Enum.reduce(%{}, &parse_paragraph/2)
  end

  def run_machine(tape, _, _, _, 0), do: tape

  def run_machine(tape, instructions, state, current, count) do
    value = Map.get(tape, current, 0)
    {next_value, direction, next_state} = Map.get(instructions, {state, value})

    run_machine(
      Map.put(tape, current, next_value),
      instructions,
      next_state,
      current + step(direction),
      count - 1
    )
  end

  def step(:left), do: -1
  def step(:right), do: 1
end
