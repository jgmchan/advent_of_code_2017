defmodule Advent.Day24Test do
  use ExUnit.Case

  @input """
  0/2
  2/2
  2/3
  3/4
  3/5
  0/1
  10/1
  9/10
  """

  describe "Part 1" do
    test "part 1" do
      graph = %{
        [0, 1] => [[0, 2], [10, 1]],
        [0, 2] => [[2, 2], [2, 3], [0, 1]],
        [10, 1] => [[0, 1], [9, 10]],
        [2, 2] => [[0, 2], [2, 3]],
        [2, 3] => [[0, 2], [2, 2], [3, 4], [3, 5]],
        [3, 4] => [[2, 3], [3, 5]],
        [3, 5] => [[2, 3], [3, 4]],
        [9, 10] => [[10, 1]]
      }

      assert Advent.Day24.parse(@input) == graph

      assert Advent.Day24.strongest([[0, 1]], 0, graph) == 31
      assert Advent.Day24.strongest([[0, 2]], 0, graph) == 19
      assert Advent.Day24.strongest([[0, 1], [0, 2]], 0, graph) == 31
      assert Advent.Day24.part_1(@input) == 31
    end
  end

  describe "Part 2" do
    test "part 2" do
      graph = %{
        [0, 1] => [[0, 2], [10, 1]],
        [0, 2] => [[2, 2], [2, 3], [0, 1]],
        [10, 1] => [[0, 1], [9, 10]],
        [2, 2] => [[0, 2], [2, 3]],
        [2, 3] => [[0, 2], [2, 2], [3, 4], [3, 5]],
        [3, 4] => [[2, 3], [3, 5]],
        [3, 5] => [[2, 3], [3, 4]],
        [9, 10] => [[10, 1]]
      }

      assert Advent.Day24.longest([[0, 1]], 0, graph) |> Map.get(:strength) == 31
      assert Advent.Day24.longest([[0, 2]], 0, graph) |> Map.get(:strength) == 19
      assert Advent.Day24.part_2(@input) == 19
    end
  end
end
