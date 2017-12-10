defmodule Advent.Day06Test do
  use ExUnit.Case

  test "Part 1" do
    assert Advent.Day06.balance(%{0 => 0, 1 => 2, 2 => 0, 3 => 0}, 3, 7) == %{
             0 => 2,
             1 => 4,
             2 => 1,
             3 => 2
           }

    {count, _} = Advent.Day06.redistribution_cycles(%{0 => 0, 1 => 2, 2 => 7, 3 => 0})
    assert count == 5
  end

  test "Part 2" do
    assert Advent.Day06.loop_cycles(%{0 => 0, 1 => 2, 2 => 7, 3 => 0}) == 4
  end
end
