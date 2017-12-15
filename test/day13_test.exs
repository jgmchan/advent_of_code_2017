defmodule Advent.Day13Test do
  use ExUnit.Case

  @input [
    "0: 3",
    "1: 2",
    "4: 4",
    "6: 4"
  ]

  describe "Part 1" do
    test "severity" do
      assert Advent.Day13.part_1(@input) == 24
    end
  end

  describe "Part 2" do
    test "delay" do
      assert Advent.Day13.part_2(@input) == 10
    end
  end
end
