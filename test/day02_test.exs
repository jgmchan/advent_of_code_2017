defmodule Advent.Day02Test do
  use ExUnit.Case

  test "Part 1" do
    spreadsheet = """
    5 1 9 5
    7 5 3
    2 4 6 8
    """

    assert Advent.Day02.part_1(spreadsheet) == 18
  end

  test "Part 2" do
    spreadsheet = """
    5 9 2 8
    9 4 7 3
    3 8 6 5
    """

    assert Advent.Day02.part_2(spreadsheet) == 9
  end
end
