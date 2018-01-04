defmodule Advent.Day22Test do
  use ExUnit.Case

  @input """
  ..#
  #..
  ...
  """

  describe "Part 1" do
    test "parse" do
      assert Advent.Day22.parse(@input) == %{
               {0, 0} => :clean,
               {1, 0} => :clean,
               {2, 0} => :infected,
               {0, 1} => :infected,
               {1, 1} => :clean,
               {2, 1} => :clean,
               {0, 2} => :clean,
               {1, 2} => :clean,
               {2, 2} => :clean
             }
    end

    test "part 1" do
      assert Advent.Day22.part_1(@input, 7) == 5
      assert Advent.Day22.part_1(@input, 70) == 41
      assert Advent.Day22.part_1(@input, 10000) == 5587
    end
  end

  describe "Part 2" do
    test "part 2" do
      assert Advent.Day22.part_2(@input, 100) == 26
      # assert Advent.Day22.part_2(@input, 10_000_000) == 2_511_944
    end
  end
end
