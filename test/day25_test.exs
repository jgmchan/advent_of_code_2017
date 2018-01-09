defmodule Advent.Day25Test do
  use ExUnit.Case

  @blueprint """
  Begin in state A.
  Perform a diagnostic checksum after 6 steps.

  In state A:
    If the current value is 0:
      - Write the value 1.
      - Move one slot to the right.
      - Continue with state B.
    If the current value is 1:
      - Write the value 0.
      - Move one slot to the left.
      - Continue with state B.

  In state B:
    If the current value is 0:
      - Write the value 1.
      - Move one slot to the left.
      - Continue with state A.
    If the current value is 1:
      - Write the value 1.
      - Move one slot to the right.
      - Continue with state A.
  """

  describe "Part 1" do
    test "parse" do
      assert Advent.Day25.parse(@blueprint) == %{
               start: :A,
               diagnostic_step: 6,
               instructions: %{
                 {:A, 0} => {1, :right, :B},
                 {:A, 1} => {0, :left, :B},
                 {:B, 0} => {1, :left, :A},
                 {:B, 1} => {1, :right, :A}
               }
             }
    end

    test "part 1" do
      assert Advent.Day25.part_1(@blueprint) == 3
    end
  end
end
