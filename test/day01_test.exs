defmodule Advent.Day01Test do
  use ExUnit.Case

  test "Part 1" do
    assert Advent.Day01.reverse_captcha('1122') == 3
    assert Advent.Day01.reverse_captcha('1111') == 4
    assert Advent.Day01.reverse_captcha('1234') == 0
    assert Advent.Day01.reverse_captcha('91212129') == 9
  end

  test "Part 2" do
    assert Advent.Day01p2.reverse_captcha('1212') == 6
    assert Advent.Day01p2.reverse_captcha('1221') == 0
    assert Advent.Day01p2.reverse_captcha('123425') == 4
    assert Advent.Day01p2.reverse_captcha('123123') == 12
    assert Advent.Day01p2.reverse_captcha('12131415') == 4
  end
end
