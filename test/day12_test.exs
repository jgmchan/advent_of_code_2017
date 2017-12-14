defmodule Advent.Day12Test do
  use ExUnit.Case

  @input """
  0 <-> 2
  1 <-> 1
  2 <-> 0, 3, 4
  3 <-> 2, 4
  4 <-> 2, 3, 6
  5 <-> 6
  6 <-> 4, 5
  """

  describe "Part 1" do
    test "graph" do
      output = %{
        0 => [2],
        1 => [1],
        2 => [0, 3, 4],
        3 => [2, 4],
        4 => [2, 3, 6],
        5 => [6],
        6 => [4, 5]
      }

      assert Advent.Day12.build_graph(@input) == output
      assert Advent.Day12.part_1(@input, 0) == 6
    end
  end

  describe "Part 2" do
    test "count groups" do
      assert Advent.Day12.part_2(@input) == 2
    end
  end
end
