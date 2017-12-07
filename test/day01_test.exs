defmodule Advent.Day01Test do
  use ExUnit.Case

  test "Part 1" do
    assert Advent.Day01.solve_1('1122') == 3
    assert Advent.Day01.solve_1('1111') == 4
    assert Advent.Day01.solve_1('1234') == 0
    assert Advent.Day01.solve_1('91212129') == 9
  end

  test "Part 2" do
    assert Advent.Day01.solve_2('1212') == 6
    assert Advent.Day01.solve_2('1221') == 0
    assert Advent.Day01.solve_2('123425') == 4
    assert Advent.Day01.solve_2('123123') == 12
    assert Advent.Day01.solve_2('12131415') == 4
  end
end
