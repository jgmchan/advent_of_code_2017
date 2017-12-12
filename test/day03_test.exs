defmodule Advent.Day03Test do
  use ExUnit.Case

  describe "Board" do
    alias Advent.Day03.Board

    test "movement" do
      board = %Board{}

      assert Board.move(board, :left).active_coord == {-1, 0}
      assert Board.move(board, :right).active_coord == {1, 0}
      assert Board.move(board, :up).active_coord == {0, 1}
      assert Board.move(board, :down).active_coord == {0, -1}
      assert Board.move(board, {2, 3}).active_coord == {2, 3}
    end

    test "values" do
      board =
        %Board{}
        |> Board.set_value({0, 0}, 100)

      assert Board.get_value(board, {0, 0}) == 100
      assert Board.get_value(board, {1, 1}) == nil
      assert Board.active_value(board) == 100
    end

    test "surrounding_values" do
      state = %{
        {0, 0} => 1,
        {1, 0} => 2,
        {1, 1} => 3,
        {0, 1} => 4,
        {-1, 1} => 5,
        {-1, 0} => 6,
        {-1, -1} => 7,
        {0, -1} => 8,
        {1, -1} => 9
      }

      board = %Board{state: state}

      assert Board.surrounding_values(board, {0, 0}) == %{
               top_left: 5,
               above: 4,
               top_right: 3,
               left: 6,
               right: 2,
               below: 8,
               bottom_left: 7,
               bottom_right: 9
             }

      assert Board.surrounding_values(board, {1, 0}) == %{
               top_left: 4,
               above: 3,
               top_right: nil,
               left: 1,
               right: nil,
               bottom_left: 8,
               below: 9,
               bottom_right: nil
             }
    end
  end

  test "find_level" do
    assert Advent.Day03.find_level(1) == 1
    assert Advent.Day03.find_level(2) == 3
    assert Advent.Day03.find_level(14) == 5
    assert Advent.Day03.find_level(26) == 7
    assert Advent.Day03.find_level(79) == 9
  end

  test "midpoint" do
    assert Advent.Day03.midpoint(10..13) == 11
    assert Advent.Day03.midpoint(14..17) == 15
    assert Advent.Day03.midpoint(18..21) == 19
    assert Advent.Day03.midpoint(22..25) == 23
  end

  test "Part 1" do
    assert Advent.Day03.part_1(1) == 0
    assert Advent.Day03.part_1(12) == 3
    assert Advent.Day03.part_1(23) == 2
    assert Advent.Day03.part_1(1024) == 31
  end

  test "Part 2" do
    #    assert Advent.Day03.part_2(1) == 1
    assert Advent.Day03.moves(2) == 1
    assert Advent.Day03.moves(3) == 2
    assert Advent.Day03.moves(4) == 4
    assert Advent.Day03.moves(5) == 5
  end
end
