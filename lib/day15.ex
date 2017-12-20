defmodule Advent.Day15 do
  @input_a 289
  @input_b 629
  @factor_a 16807
  @factor_b 48271
  @divisor 2_147_483_647

  use Bitwise

  def solve_1 do
    part_1(@input_a, @input_b)
  end

  def solve_2 do
    part_2(@input_a, @input_b)
  end

  def part_1(input_a, input_b) do
    loop(input_a, input_b, &basic_generator_x/2, 40_000_000)
  end

  def part_2(input_a, input_b) do
    loop(input_a, input_b, &picky_generator_x/2, 5_000_000)
  end

  def basic_generator_x(input, :a), do: basic_generator(input, @factor_a)
  def basic_generator_x(input, :b), do: basic_generator(input, @factor_b)
  def basic_generator(input, factor, divisor \\ @divisor), do: rem(input * factor, divisor)

  def picky_generator_x(input, :a), do: picky_generator(input, @factor_a, 4)
  def picky_generator_x(input, :b), do: picky_generator(input, @factor_b, 8)

  def picky_generator(input, factor, multiple, divisor \\ @divisor) do
    result = rem(input * factor, divisor)

    if rem(result, multiple) == 0,
      do: result,
      else: picky_generator(result, factor, multiple, divisor)
  end

  def judge(a, b, count \\ 0) do
    if last_16_bits(a) == last_16_bits(b), do: count + 1, else: count
  end

  def loop(input_a, input_b, gen_type, times, count \\ 0)
  def loop(_, _, _, 0, count), do: count

  def loop(input_a, input_b, gen_type, times, count) do
    output_a = gen_type.(input_a, :a)
    output_b = gen_type.(input_b, :b)

    loop(output_a, output_b, gen_type, times - 1, judge(output_a, output_b, count))
  end

  defp last_16_bits(bitstring), do: :binary.encode_unsigned(bitstring &&& 0xFFFF)
end
