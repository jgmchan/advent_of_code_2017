defmodule Advent.Day09Test do
  use ExUnit.Case

  describe "Part 1" do
    test "garbage" do
      assert Advent.Day09.parse("<>") |> Map.get(:stack) == []
      assert Advent.Day09.parse("<random characters>") |> Map.get(:stack) == []
      assert Advent.Day09.parse("<<<<>") |> Map.get(:stack) == []
      assert Advent.Day09.parse("<{!>}>") |> Map.get(:stack) == []
      assert Advent.Day09.parse("<!!>") |> Map.get(:stack) == []
      assert Advent.Day09.parse("<!!!>>") |> Map.get(:stack) == []
      assert Advent.Day09.parse("<{o\"i!a,<{i<a>") |> Map.get(:stack) == []
    end

    test "groups" do
      assert Advent.Day09.parse("{}") |> Map.get(:stack) == [group_end: 1, group_start: 1]

      assert Advent.Day09.parse("{{{}}}") |> Map.get(:stack) == [
               group_end: 1,
               group_end: 2,
               group_end: 3,
               group_start: 3,
               group_start: 2,
               group_start: 1
             ]

      assert Advent.Day09.parse("{{},{}}") |> Map.get(:stack) == [
               group_end: 1,
               group_end: 2,
               group_start: 2,
               group_end: 2,
               group_start: 2,
               group_start: 1
             ]

      assert Advent.Day09.parse("{{{},{},{{}}}}") |> Map.get(:stack) == [
               group_end: 1,
               group_end: 2,
               group_end: 3,
               group_end: 4,
               group_start: 4,
               group_start: 3,
               group_end: 3,
               group_start: 3,
               group_end: 3,
               group_start: 3,
               group_start: 2,
               group_start: 1
             ]

      assert Advent.Day09.parse("{<{},{},{{}}>}") |> Map.get(:stack) == [
               group_end: 1,
               group_start: 1
             ]

      assert Advent.Day09.parse("{<a>,<a>,<a>,<a>}") |> Map.get(:stack) == [
               group_end: 1,
               group_start: 1
             ]

      assert Advent.Day09.parse("{{<a>},{<a>},{<a>},{<a>}}") |> Map.get(:stack) == [
               group_end: 1,
               group_end: 2,
               group_start: 2,
               group_end: 2,
               group_start: 2,
               group_end: 2,
               group_start: 2,
               group_end: 2,
               group_start: 2,
               group_start: 1
             ]

      assert Advent.Day09.parse("{{<!>},{<!>},{<!>},{<a>}}") |> Map.get(:stack) == [
               group_end: 1,
               group_end: 2,
               group_start: 2,
               group_start: 1
             ]
    end

    test "score" do
      assert Advent.Day09.score("{}") == 1
      assert Advent.Day09.score("{{{}}}") == 1 + 2 + 3
      assert Advent.Day09.score("{{},{}}") == 1 + 2 + 2
      assert Advent.Day09.score("{{{},{},{{}}}}") == 1 + 2 + 3 + 3 + 3 + 4
      assert Advent.Day09.score("{<a>,<a>,<a>,<a>}") == 1
      assert Advent.Day09.score("{{<ab>},{<ab>},{<ab>},{<ab>}}") == 1 + 2 + 2 + 2 + 2
      assert Advent.Day09.score("{{<!!>},{<!!>},{<!!>},{<!!>}}") == 1 + 2 + 2 + 2 + 2
      assert Advent.Day09.score("{{<a!>},{<a!>},{<a!>},{<ab>}}") == 1 + 2
    end
  end

  describe "Part 2" do
    test "garbage count" do
      assert Advent.Day09.garbage_count("<>") == 0
      assert Advent.Day09.garbage_count("<random characters>") == 17
      assert Advent.Day09.garbage_count("<<<<>") == 3
      assert Advent.Day09.garbage_count("<{!>}>") == 2
      assert Advent.Day09.garbage_count("<!!>") == 0
      assert Advent.Day09.garbage_count("<!!!>>") == 0
      assert Advent.Day09.garbage_count("<{o\"i!a,<{i<a>") == 10
    end
  end
end
