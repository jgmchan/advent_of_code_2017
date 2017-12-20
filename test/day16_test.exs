defmodule Advent.Day16Test do
  use ExUnit.Case

  describe "Part 1" do
    test "swap" do
      list = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
      assert Advent.Day16.swap(list, 2, 9) == [0, 1, 9, 3, 4, 5, 6, 7, 8, 2, 10]
      assert Advent.Day16.swap(list, 9, 2) == [0, 1, 9, 3, 4, 5, 6, 7, 8, 2, 10]
      assert Advent.Day16.swap(list, 4, 5) == [0, 1, 2, 3, 5, 4, 6, 7, 8, 9, 10]
      assert Advent.Day16.swap(list, 5, 4) == [0, 1, 2, 3, 5, 4, 6, 7, 8, 9, 10]
      assert Advent.Day16.swap(list, 4, 6) == [0, 1, 2, 3, 6, 5, 4, 7, 8, 9, 10]
      assert Advent.Day16.swap(list, 6, 4) == [0, 1, 2, 3, 6, 5, 4, 7, 8, 9, 10]
      assert Advent.Day16.swap(list, 0, 10) == [10, 1, 2, 3, 4, 5, 6, 7, 8, 9, 0]
      assert Advent.Day16.swap(list, 10, 0) == [10, 1, 2, 3, 4, 5, 6, 7, 8, 9, 0]
    end

    test "moves" do
      start = ["a", "b", "c", "d", "e"]
      assert Advent.Day16.move(start, {:s, [1]}) == ["e", "a", "b", "c", "d"]
      assert Advent.Day16.move(start, {:x, [3, 4]}) == ["a", "b", "c", "e", "d"]
      assert Advent.Day16.move(start, {:p, ["e", "b"]}) == ["a", "e", "c", "d", "b"]
    end

    test "part 1" do
      start = ["a", "b", "c", "d", "e"]
      assert Advent.Day16.part_1(start, "s1,x3/4,pe/b") == ["b", "a", "e", "d", "c"]
    end
  end

  describe "Part 2" do
    test "cycle" do
      start = ["a", "b", "c", "d", "e"]
      moves = Advent.Day16.parse("s1,x3/4,pe/b")
      assert Advent.Day16.detect_cycle(start, moves) == 4
    end
  end
end
