defmodule Advent.Day23Test do
  use ExUnit.Case

  describe "Part 1" do
    setup do
      %{
        state: %{
          registers: %{a: 1},
          current: 0,
          mul_count: 0
        }
      }
    end

    test "run", %{state: state} do
      %{registers: %{a: 4}} = Advent.Day23.run(state, {:set, [:a, 4]})
      %{registers: %{a: -4}} = Advent.Day23.run(state, {:sub, [:a, 5]})
      %{registers: %{a: 5}} = Advent.Day23.run(state, {:mul, [:a, 5]})
      %{current: 2} = Advent.Day23.run(state, {:jnz, [:a, 2]})
      %{current: 1} = Advent.Day23.run(state, {:jnz, [:b, 2]})
      %{current: 1} = Advent.Day23.run(state, {:jnz, [0, 2]})
      %{current: 2} = Advent.Day23.run(state, {:jnz, [1, 2]})
      %{current: 1} = Advent.Day23.run(state, {:jnz, [1, 1]})
    end
  end

  describe "Part 2" do
    test "part 2" do
      assert Advent.Day23.not_prime_number(106_700) == true
      assert Advent.Day23.not_prime_number(140_629) == false
    end
  end
end
