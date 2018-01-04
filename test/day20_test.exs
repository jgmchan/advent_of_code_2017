defmodule Advent.Day20Test do
  use ExUnit.Case

  describe "Part 1" do
    test "parse" do
      assert Advent.Day20.parse("p=<1199,-2918,1457>, v=<-13,115,-8>, a=<-7,8,-10>") ==
               {{1199, -2918, 1457}, {-13, 115, -8}, {-7, 8, -10}}
    end

    test "solve_1" do
      assert Advent.Day20.solve_1() == 243
    end
  end

  describe "Part 2" do
    test "move_particle" do
      assert Advent.Day20.move_particle({{3, 0, 0}, {2, 0, 0}, {-1, 0, 0}}) ==
               {{4, 0, 0}, {1, 0, 0}, {-1, 0, 0}}

      assert Advent.Day20.move_particle({{4, 0, 0}, {1, 0, 0}, {-1, 0, 0}}) ==
               {{4, 0, 0}, {0, 0, 0}, {-1, 0, 0}}

      assert Advent.Day20.move_particle({{4, 0, 0}, {0, 0, 0}, {-1, 0, 0}}) ==
               {{3, 0, 0}, {-1, 0, 0}, {-1, 0, 0}}
    end

    test "collision" do
      input = [
        {{-6, 0, 0}, {3, 0, 0}, {0, 0, 0}},
        {{-4, 0, 0}, {2, 0, 0}, {0, 0, 0}},
        {{-2, 0, 0}, {1, 0, 0}, {0, 0, 0}},
        {{3, 0, 0}, {-1, 0, 0}, {0, 0, 0}}
      ]

      output =
        input
        |> Advent.Day20.tick()
        |> Advent.Day20.tick()
        |> Advent.Day20.tick()

      assert output == [{{0, 0, 0}, {-1, 0, 0}, {0, 0, 0}}]
    end

    #    test "part 2" do
    #      assert Advent.Day20.solve_2() == 1
    #    end
  end
end
