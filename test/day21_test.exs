defmodule Advent.Day21Test do
  use ExUnit.Case

  @rules [
    "../.# => ##./#../...",
    ".#./..#/### => #..#/..../..../#..#"
  ]
  describe "Part 1" do
    test "parse" do
      input = ["#./.. => #.#/#.#/.#."]
      assert Advent.Day21.parse(input) |> map_size == 4
    end

    test "convert" do
      assert Advent.Day21.convert("..#./##.#/#.##/##.#") ==
               [
                 [0, 0, 1, 0],
                 [1, 1, 0, 1],
                 [1, 0, 1, 1],
                 [1, 1, 0, 1]
               ]
    end

    test "rotate" do
      input = [
        [1, 1, 0],
        [0, 0, 1],
        [1, 0, 0]
      ]

      assert Advent.Day21.transpose(input) ==
               [
                 [1, 0, 1],
                 [1, 0, 0],
                 [0, 1, 0]
               ]

      assert Advent.Day21.rotate_right(input) ==
               [
                 [1, 0, 1],
                 [0, 0, 1],
                 [0, 1, 0]
               ]

      assert Advent.Day21.rotate_180(input) ==
               [
                 [0, 0, 1],
                 [1, 0, 0],
                 [0, 1, 1]
               ]

      assert Advent.Day21.rotate_left(input) ==
               [
                 [0, 1, 0],
                 [1, 0, 0],
                 [1, 0, 1]
               ]

      assert Advent.Day21.flip_horizontal(input) ==
               [
                 [0, 1, 1],
                 [1, 0, 0],
                 [0, 0, 1]
               ]

      assert Advent.Day21.flip_vertical(input) ==
               [
                 [1, 0, 0],
                 [0, 0, 1],
                 [1, 1, 0]
               ]

      assert Advent.Day21.reverse_transpose(input) ==
               [
                 [0, 1, 0],
                 [0, 0, 1],
                 [1, 0, 1]
               ]
    end

    test "divide" do
      pattern = [
        [1, 1, 1],
        [0, 0, 1],
        [0, 1, 0]
      ]

      assert Advent.Day21.divide(pattern) == [
               [
                 [1, 1, 1],
                 [0, 0, 1],
                 [0, 1, 0]
               ]
             ]

      pattern = [
        [1, 0, 0, 1, 1, 1],
        [0, 0, 0, 0, 1, 1],
        [0, 0, 0, 0, 1, 1],
        [1, 0, 0, 1, 1, 1],
        [1, 0, 0, 1, 1, 1],
        [1, 0, 0, 1, 1, 1]
      ]

      assert Advent.Day21.divide(pattern) == [
               [
                 [1, 0],
                 [0, 0]
               ],
               [
                 [0, 1],
                 [0, 0]
               ],
               [
                 [1, 1],
                 [1, 1]
               ],
               [
                 [0, 0],
                 [1, 0]
               ],
               [
                 [0, 0],
                 [0, 1]
               ],
               [
                 [1, 1],
                 [1, 1]
               ],
               [
                 [1, 0],
                 [1, 0]
               ],
               [
                 [0, 1],
                 [0, 1]
               ],
               [
                 [1, 1],
                 [1, 1]
               ]
             ]

      pattern = [
        [1, 0, 0, 1],
        [0, 0, 0, 0],
        [0, 0, 0, 0],
        [1, 0, 0, 1]
      ]

      assert Advent.Day21.divide(pattern) == [
               [
                 [1, 0],
                 [0, 0]
               ],
               [
                 [0, 1],
                 [0, 0]
               ],
               [
                 [0, 0],
                 [1, 0]
               ],
               [
                 [0, 0],
                 [0, 1]
               ]
             ]
    end

    test "join" do
      input = [
        [
          [1, 1, 0],
          [1, 0, 0],
          [0, 0, 0]
        ],
        [
          [1, 1, 0],
          [1, 0, 0],
          [0, 0, 0]
        ],
        [
          [1, 1, 0],
          [1, 0, 0],
          [0, 0, 0]
        ],
        [
          [1, 1, 0],
          [1, 0, 0],
          [0, 0, 0]
        ]
      ]

      output = [
        [1, 1, 0, 1, 1, 0],
        [1, 0, 0, 1, 0, 0],
        [0, 0, 0, 0, 0, 0],
        [1, 1, 0, 1, 1, 0],
        [1, 0, 0, 1, 0, 0],
        [0, 0, 0, 0, 0, 0]
      ]

      assert Advent.Day21.join(input) == output
    end

    test "enhance" do
      rules = Advent.Day21.parse(@rules)

      input = [
        [0, 1, 0],
        [0, 0, 1],
        [1, 1, 1]
      ]

      output = [
        [1, 0, 0, 1],
        [0, 0, 0, 0],
        [0, 0, 0, 0],
        [1, 0, 0, 1]
      ]

      assert Advent.Day21.enhance(input, rules) == output

      input = [
        [1, 0, 0, 1],
        [0, 0, 0, 0],
        [0, 0, 0, 0],
        [1, 0, 0, 1]
      ]

      output = [
        [1, 1, 0, 1, 1, 0],
        [1, 0, 0, 1, 0, 0],
        [0, 0, 0, 0, 0, 0],
        [1, 1, 0, 1, 1, 0],
        [1, 0, 0, 1, 0, 0],
        [0, 0, 0, 0, 0, 0]
      ]

      assert Advent.Day21.enhance(input, rules) == output
    end

    test "part 1" do
      assert @rules
             |> Advent.Day21.part_1(2) == 12
    end
  end

  describe "Part 2" do
  end
end
