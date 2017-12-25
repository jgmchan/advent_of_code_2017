defmodule Advent.Day19Test do
  use ExUnit.Case

  @input "     |         \n     |  +--+   \n     A  |  C   \n F---|----E|--+\n     |  |  |  D\n     +B-+  +--+"

  describe "Part 1" do
    test "part 1" do
      assert Advent.Day19.part_1(@input) |> elem(0) == 'ABCDEF'
    end
  end

  describe "Part 2" do
    test "part 2" do
      assert Advent.Day19.part_2(@input) |> elem(1) == 38
    end
  end
end
