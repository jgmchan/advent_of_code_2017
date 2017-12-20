defmodule Advent.Day15Test do
  use ExUnit.Case

  @input_a 65
  @input_b 8921

  describe "Part 1" do
    test "generators" do
      assert Advent.Day15.basic_generator_x(@input_a, :a)
             |> Advent.Day15.basic_generator_x(:a)
             |> Advent.Day15.basic_generator_x(:a)
             |> Advent.Day15.basic_generator_x(:a)
             |> Advent.Day15.basic_generator_x(:a) == 1_352_636_452

      assert Advent.Day15.basic_generator_x(@input_b, :b)
             |> Advent.Day15.basic_generator_x(:b)
             |> Advent.Day15.basic_generator_x(:b)
             |> Advent.Day15.basic_generator_x(:b)
             |> Advent.Day15.basic_generator_x(:b) == 285_222_916
    end

    test "loop" do
      assert Advent.Day15.loop(@input_a, @input_b, &Advent.Day15.basic_generator_x/2, 5) == 1
    end

    @tag :skip
    test "part 1" do
      assert Advent.Day15.part_1(@input_a, @input_b) == 588
    end
  end

  describe "Part 2" do
    test "generators" do
      assert Advent.Day15.picky_generator_x(@input_a, :a)
             |> Advent.Day15.picky_generator_x(:a)
             |> Advent.Day15.picky_generator_x(:a)
             |> Advent.Day15.picky_generator_x(:a)
             |> Advent.Day15.picky_generator_x(:a) == 740_335_192

      assert Advent.Day15.picky_generator_x(@input_b, :b)
             |> Advent.Day15.picky_generator_x(:b)
             |> Advent.Day15.picky_generator_x(:b)
             |> Advent.Day15.picky_generator_x(:b)
             |> Advent.Day15.picky_generator_x(:b) == 412_269_392
    end

    test "loop" do
      assert Advent.Day15.loop(@input_a, @input_b, &Advent.Day15.picky_generator_x/2, 1056) == 1
    end

    @tag :skip
    test "part 2" do
      assert Advent.Day15.part_2(@input_a, @input_b) == 309
    end
  end
end
