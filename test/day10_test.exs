defmodule Advent.Day10Test do
  use ExUnit.Case

  describe "Part 1" do
    test "circular_list" do
      assert Advent.Day10.in_circular_list(
               [0, 1, 2, 3, 4],
               0,
               &Advent.Day10.reverse_section(&1, 3)
             ) == [2, 1, 0, 3, 4]

      assert Advent.Day10.in_circular_list(
               [2, 1, 0, 3, 4],
               3,
               &Advent.Day10.reverse_section(&1, 4)
             ) == [4, 3, 0, 1, 2]

      assert Advent.Day10.in_circular_list(
               [4, 3, 0, 1, 2],
               3,
               &Advent.Day10.reverse_section(&1, 1)
             ) == [4, 3, 0, 1, 2]

      assert Advent.Day10.in_circular_list(
               [4, 3, 0, 1, 2],
               1,
               &Advent.Day10.reverse_section(&1, 5)
             ) == [3, 4, 2, 1, 0]
    end

    test "step" do
      assert Advent.Day10.step([0, 1, 2, 3, 4], [3, 4, 1, 5]) |> elem(0) == [3, 4, 2, 1, 0]
    end

    test "calculate" do
      assert Advent.Day10.part_1([0, 1, 2, 3, 4], [3, 4, 1, 5]) == 12
    end
  end

  describe "Part 2" do
    test "dense hash" do
      assert Advent.Day10.dense_hash([65, 27, 9, 1, 4, 3, 40, 50, 91, 7, 6, 0, 2, 5, 68, 22]) == [
               64
             ]
    end

    test "convert to hash" do
      assert Advent.Day10.to_knot_hash([64, 7, 255]) == "4007ff"
    end

    test "part_1" do
      assert Advent.Day10.part_2(0..255, "") == "a2582a3a0e66e6e86e3812dcb672a272"
      assert Advent.Day10.part_2(0..255, "AoC 2017") == "33efeb34ea91902bb2f59c9920caa6cd"
      assert Advent.Day10.part_2(0..255, "1,2,3") == "3efbe78a8d82f29979031a4aa0b16a9d"
      assert Advent.Day10.part_2(0..255, "1,2,4") == "63960835bcdc130f0b66d7ff4f6a5a8e"
    end
  end
end
