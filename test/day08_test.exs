defmodule Advent.Day08Test do
  use ExUnit.Case

  @input """
  b inc 5 if a > 1
  a inc 1 if b < 5
  c dec -10 if a >= 1
  c inc -20 if c == 10
  """

  describe "Part 1" do
    test "parse" do
      assert Advent.Day08.parse("b inc 5 if a > 1") == {:b, :inc, 5, {:>, :a, 1}}
    end

    test "instructions" do
      assert Advent.Day08.execute_instruction(%{}, {:b, :inc, 5, {:>, :a, 1}}) == %{}
      assert Advent.Day08.execute_instruction(%{}, {:a, :inc, 1, {:<, :b, 5}}) == %{a: 1}
      assert Advent.Day08.execute_instruction(%{}, {:a, :inc, 1, {:<, :b, 5}}) == %{a: 1}
    end

    test "execute_all" do
      registers =
        @input
        |> String.split("\n", trim: true)
        |> Advent.Day08.execute_all()

      assert registers == {10, %{a: 1, c: -10}}
    end
  end
end
