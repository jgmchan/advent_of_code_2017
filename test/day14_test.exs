defmodule Advent.Day14Test do
  use ExUnit.Case

  @input "flqrgnkx"

  describe "Part 1" do
    test "part 1" do
      assert Advent.Day14.convert_to_integer("ff11") == [15, 15, 1, 1]
      # assert Advent.Day14.part_1(@input) == 8108
    end
  end

  describe "Part 2" do
    test "part 2" do
      input = [
        [0, 0, 0, 1, 1, 1, 0, 0],
        [0, 0, 0, 1, 1, 1, 0, 0],
        [0, 1, 1, 0, 1, 0, 1, 1],
        [0, 1, 1, 1, 1, 1, 1, 1],
        [0, 1, 1, 0, 1, 0, 1, 1],
        [0, 0, 0, 1, 1, 1, 0, 0],
        [0, 0, 0, 1, 1, 1, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0]
      ]

      mapset = Advent.Day14.bitmap_to_mapset(input)

      assert Advent.Day14.count_regions(mapset) == 1

      input = [
        [0, 0, 0, 1, 1, 1, 0, 0],
        [0, 0, 0, 1, 1, 1, 0, 0],
        [0, 1, 1, 0, 1, 0, 1, 1],
        [0, 1, 1, 1, 0, 1, 1, 1],
        [0, 1, 1, 0, 1, 0, 1, 1],
        [0, 0, 0, 1, 1, 1, 0, 0],
        [0, 0, 0, 1, 1, 1, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0]
      ]

      mapset = Advent.Day14.bitmap_to_mapset(input)

      assert Advent.Day14.count_regions(mapset) == 4

      # assert Advent.Day14.part_2(@input) == 1242
    end
  end
end
