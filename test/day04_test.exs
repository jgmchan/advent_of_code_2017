defmodule Advent.Day04Test do
  use ExUnit.Case

  describe "Part 1" do
    test "duplicate" do
      assert Advent.Day04.duplicate?("aa bb cc dd ee")
      refute Advent.Day04.duplicate?("aa bb cc dd aa")
      assert Advent.Day04.duplicate?("aa bb cc dd aaa")
    end
  end

  describe "Part 2" do
    test "anagram" do
      assert Advent.Day04.anagram?("abcde fghij")
      refute Advent.Day04.anagram?("abcde xyz ecdab")
      assert Advent.Day04.anagram?("a ab abc abd abf abj")
      assert Advent.Day04.anagram?("iiii oiii ooii oooi oooo")
      refute Advent.Day04.anagram?("oiii ioii iioi iiio")
    end
  end
end
