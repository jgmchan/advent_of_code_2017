defmodule Advent.Day07Test do
  use ExUnit.Case

  @input %{
    "pbga" => {66, []},
    "xhth" => {57, []},
    "ebii" => {61, []},
    "havc" => {66, []},
    "ktlj" => {57, []},
    "fwft" => {72, ["ktlj", "cntj", "xhth"]},
    "qoyq" => {66, []},
    "tknk" => {41, ["ugml", "padx", "fwft"]},
    "padx" => {45, ["pbga", "havc", "qoyq"]},
    "jptl" => {61, []},
    "ugml" => {68, ["gyxo", "ebii", "jptl"]},
    "gyxo" => {61, []},
    "cntj" => {57, []}
  }

  describe "Part 1" do
    test "transform input" do
      assert Advent.Day07.convert("kozpul (59) -> shavjjt, anujsv, tnzvo") ==
               {"kozpul", {59, ["shavjjt", "anujsv", "tnzvo"]}}

      assert Advent.Day07.convert("occxa (60)") == {"occxa", {60, []}}
    end

    test "find root" do
      assert Advent.Day07.find_root(@input) == "tknk"
    end
  end

  test "Part 2" do
    assert Advent.Day07.total_weight(@input, "cntj", 57, []) == 57

    assert Advent.Day07.total_weight(@input, "ugml", 68, ["gyxo", "ebii", "jptl"]) ==
             68 + 61 + 61 + 61

    assert Advent.Day07.is_balanced?(@input, ["gyxo", "ebii", "jptl"]) == {true, [], 61}
    assert Advent.Day07.is_balanced?(@input, ["ugml", "padx", "fwft"]) == {false, ["ugml"], 243}

    assert Advent.Day07.find_wrong_program(@input, "tknk") == [{"ugml", 60}]
  end
end
