defmodule Advent.Day17Test do
  use ExUnit.Case

  describe "Part 1" do
    test "buffer" do
      assert Advent.Day17.step({[0], 0}, 1, 3) == {[0, 1], 1}
      assert Advent.Day17.step({[0, 1], 1}, 2, 3) == {[0, 2, 1], 1}
      assert Advent.Day17.step({[0, 2, 1], 1}, 3, 3) == {[0, 2, 3, 1], 2}
    end

    test "part 1" do
      assert Advent.Day17.part_1(3, 1) == 0
      assert Advent.Day17.part_1(3, 2) == 1
      assert Advent.Day17.part_1(3, 3) == 1
      assert Advent.Day17.part_1(3, 4) == 3
      assert Advent.Day17.part_1(3, 5) == 2
      assert Advent.Day17.part_1(3, 6) == 1
      assert Advent.Day17.part_1(3, 7) == 2
      assert Advent.Day17.part_1(3, 8) == 6
      assert Advent.Day17.part_1(3, 9) == 5
    end
  end

  describe "Part 2" do
    test "step 2" do
      assert Advent.Day17.step2({nil, 0}, 1, 3) == {1, 1}
      assert Advent.Day17.step2({1, 1}, 2, 3) == {2, 1}
      assert Advent.Day17.step2({2, 1}, 3, 3) == {2, 2}
      assert Advent.Day17.step2({2, 2}, 4, 3) == {2, 2}
      assert Advent.Day17.step2({2, 2}, 5, 3) == {5, 1}
      assert Advent.Day17.step2({5, 1}, 6, 3) == {5, 5}
      assert Advent.Day17.step2({5, 5}, 7, 3) == {5, 2}
      assert Advent.Day17.step2({5, 2}, 8, 3) == {5, 6}
      assert Advent.Day17.step2({5, 6}, 9, 3) == {9, 1}
    end

    test "part 2" do
      assert Advent.Day17.part_2(3, 1) == 1
      assert Advent.Day17.part_2(3, 2) == 2
      assert Advent.Day17.part_2(3, 3) == 2
      assert Advent.Day17.part_2(3, 4) == 2
      assert Advent.Day17.part_2(3, 5) == 5
      assert Advent.Day17.part_2(3, 6) == 5
      assert Advent.Day17.part_2(3, 7) == 5
      assert Advent.Day17.part_2(3, 8) == 5
      assert Advent.Day17.part_2(3, 9) == 9
    end
  end
end
