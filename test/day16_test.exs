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

    test "dance" do
      start = ["a", "b", "c", "d", "e"]
      assert Advent.Day16.do_dance(start, "s1,x3/4,pe/b", 1) == ["b", "a", "e", "d", "c"]
    end
  end

  describe "Part 2" do
    test "dance" do
      start = ["a", "b", "c", "d", "e"]
      moves = "s1,x3/4,pe/b"

      assert Advent.Day16.do_dance(start, moves, 1_000_000_000) == ["a", "b", "c", "d", "e"]
    end
  end
end
