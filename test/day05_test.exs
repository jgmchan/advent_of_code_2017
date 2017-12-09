defmodule Advent.Day05Test do
  use ExUnit.Case

  describe "Part 1" do
    assert Advent.Day05.map_of([1, 2, 3, 4]) == %{0 => 1, 1 => 2, 2 => 3, 3 => 4}
    assert Advent.Day05.part_1([0, 3, 0, 1, -3]) == 5
  end

  describe "Part 2" do
    assert Advent.Day05.part_2([0, 3, 0, 1, -3]) == 10
  end
end
