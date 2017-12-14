defmodule Advent.Day03.Board do
  alias __MODULE__

  defstruct active_coord: {0, 0},
            state: %{}

  def move(%Board{active_coord: active_coord} = board, :left),
    do: move(board, position(:left_of, active_coord))

  def move(%Board{active_coord: active_coord} = board, :right),
    do: move(board, position(:right_of, active_coord))

  def move(%Board{active_coord: active_coord} = board, :up),
    do: move(board, position(:above_of, active_coord))

  def move(%Board{active_coord: active_coord} = board, :down),
    do: move(board, position(:below_of, active_coord))

  def move(%Board{} = board, position) when is_tuple(position) do
    %{board | active_coord: position}
  end

  def position(:left_of, {x, y}), do: {x - 1, y}
  def position(:right_of, {x, y}), do: {x + 1, y}
  def position(:above_of, {x, y}), do: {x, y + 1}
  def position(:below_of, {x, y}), do: {x, y - 1}
  def position(:top_right_of, {x, y}), do: {x + 1, y + 1}
  def position(:top_left_of, {x, y}), do: {x - 1, y + 1}
  def position(:bottom_left_of, {x, y}), do: {x - 1, y - 1}
  def position(:bottom_right_of, {x, y}), do: {x + 1, y - 1}

  def active_value(%Board{active_coord: active_coord} = board) do
    get_value(board, active_coord)
  end

  def get_value(%Board{state: state}, coord) do
    Map.get(state, coord)
  end

  def set_value(%Board{state: state} = board, coord, value) do
    %{board | state: Map.put(state, coord, value)}
  end

  def surrounding_values(%Board{} = board, coord) do
    value = fn of -> get_value(board, position(of, coord)) end

    %{
      top_left: value.(:top_left_of),
      above: value.(:above_of),
      top_right: value.(:top_right_of),
      left: value.(:left_of),
      right: value.(:right_of),
      below: value.(:below_of),
      bottom_left: value.(:bottom_left_of),
      bottom_right: value.(:bottom_right_of)
    }
  end

  def next_spiral_move(%{left: v, above: nil}) when not is_nil(v), do: :up
  def next_spiral_move(%{below: v, left: nil}) when not is_nil(v), do: :left
  def next_spiral_move(%{right: v, below: nil}) when not is_nil(v), do: :down
  def next_spiral_move(%{above: v, right: nil}) when not is_nil(v), do: :right
  def next_spiral_move(%{right: nil, left: nil, above: nil, below: nil}), do: :right
end

defmodule Advent.Day03 do
  alias Advent.Day03.Board
  @input 347_991

  # Part 1
  # 17  16  15  14  13
  # 18   5   4   3  12
  # 19   6   1   2  11
  # 20   7   8   9  10
  # 21  22  23  24  25
  #

  # Part 2
  # 147  142  133  122   59
  # 304    5    4    2   57
  # 330   10    1    1   54
  # 351   11   23   25   26
  # 362  747  806
  #

  def solve_1, do: steps(@input)

  def solve_2, do: part_2(@input)

  def part_2(target, num \\ 1, value \\ 0)
  def part_2(target, _num, value) when value > target, do: value
  def part_2(target, num, _value), do: part_2(target, num + 1, moves(num))

  def moves(num) do
    next_step = fn board ->
      next_move =
        board
        |> Board.surrounding_values(board.active_coord)
        |> Board.next_spiral_move()

      board = Board.move(board, next_move)

      Board.set_value(
        board,
        board.active_coord,
        Map.values(Board.surrounding_values(board, board.active_coord)) |> Enum.filter(& &1)
        |> Enum.sum()
      )
    end

    board = %Board{state: %{{0, 0} => 1}}

    Enum.reduce(2..num, board, fn _, acc ->
      acc |> next_step.()
    end)
    |> Board.active_value()
  end

  def steps(num) do
    level = find_level(num)
    ranges = side_ranges(level)
    target_range = Enum.find(ranges, fn range -> num in range end)
    mid = midpoint(target_range)
    distance = abs(mid - num)
    real_level = div(level - 1, 2)
    distance + real_level
  end

  #    div(level - 1, 2) + 1)
  def find_level(num, level \\ 1)
  def find_level(1, _), do: 1
  def find_level(num, level) when level * level > num, do: level
  def find_level(num, level), do: find_level(num, level + 2)

  defp side_ranges(level) do
    prev_level = level - 2
    min = prev_level * prev_level + 1
    max = level * level
    size = max - min + 1
    side_length = div(size, 4)

    for side <- 0..3 do
      range_min = min + side * side_length
      range_max = range_min + side_length - 1

      range_min..range_max
    end
  end

  def midpoint(range) do
    len = range.last - range.first + 1
    half_len = div(len, 2)
    range.first + half_len - 1
  end

  def part_1(num) do
    steps(num)
  end
end
