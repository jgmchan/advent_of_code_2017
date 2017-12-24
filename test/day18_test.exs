defmodule Advent.Day18Test do
  use ExUnit.Case

  @input """
  set a 1
  add a 2
  mul a a
  mod a 5
  snd a
  set a 0
  rcv a
  jgz a -1
  set a 1
  jgz a -2
  """

  @instructions {
                  {:set, [:a, 1]},
                  {:add, [:a, 2]},
                  {:mul, [:a, :a]},
                  {:mod, [:a, 5]},
                  {:snd, [:a]},
                  {:set, [:a, 0]},
                  {:rcv, [:a]},
                  {:jgz, [:a, -1]},
                  {:set, [:a, 1]},
                  {:jgz, [:a, -2]}
                }

  describe "Part 1" do
    setup do
      %{
        state: %{
          registers: %{a: 1},
          current: 0,
          played: 3,
          recovered: 1
        }
      }
    end

    test "parser" do
      assert Advent.Day18.parse(@input) == @instructions
    end

    test "run", %{state: state} do
      %{registers: %{a: 4}} = Advent.Day18.run(state, {:set, [:a, 4]})
      %{registers: %{a: 6}} = Advent.Day18.run(state, {:add, [:a, 5]})
      %{registers: %{a: 5}} = Advent.Day18.run(state, {:mul, [:a, 5]})
      %{registers: %{a: 1}} = Advent.Day18.run(state, {:mod, [:a, 3]})
      %{played: 1} = Advent.Day18.run(state, {:snd, [:a]})
      %{recovered: 3} = Advent.Day18.run(state, {:rcv, [:a]})
      %{recovered: 1} = Advent.Day18.run(state, {:rcv, [:b]})
      %{current: 2} = Advent.Day18.run(state, {:jgz, [:a, 2]})
      %{current: 1} = Advent.Day18.run(state, {:jgz, [:b, 2]})
      %{current: 2} = Advent.Day18.run(state, {:jgz, [1, 2]})
      %{current: 1} = Advent.Day18.run(state, {:jgz, [1, 1]})
    end

    test "execute" do
      %{recovered: 4} = Advent.Day18.execute(@instructions)
    end
  end

  describe "Part 2" do
    test "part 2" do
      input = """
      snd 1
      snd 2
      snd p
      rcv a
      rcv b
      rcv c
      rcv d
      """

      {_, %{send_count: 3}} = Advent.Day18.part_2(input)
    end
  end
end
