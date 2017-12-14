defmodule Advent.Day11Test do
  use ExUnit.Case

  describe "Part 1" do
    test "distance" do
      assert Advent.Day11.part_1(["ne", "ne", "ne"]) == 3
      assert Advent.Day11.part_1(["ne", "ne", "sw", "sw"]) == 0
      assert Advent.Day11.part_1(["ne", "ne", "s", "s"]) == 2
      assert Advent.Day11.part_1(["se", "sw", "se", "sw", "sw"]) == 3
    end
  end

  describe "Part 2" do
  end
end
