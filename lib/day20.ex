defmodule Advent.Day20 do
  @input "inputs/day20_input"

  def solve_1 do
    File.stream!(@input)
    |> part_1()
  end

  def solve_2 do
    File.stream!(@input)
    |> part_2()
    |> Enum.count()
  end

  def part_1(input) do
    particles =
      input
      |> Enum.map(&parse/1)
      |> Enum.map(fn {_, v, a} ->
        {distance(a), distance(v)}
      end)

    min = Enum.min(particles)

    Enum.find_index(particles, &(&1 == min))
  end

  def part_2(input) do
    input
    |> Enum.map(&parse/1)
    |> simulate
  end

  def simulate(particles, count \\ 1000)
  def simulate(particles, 0), do: particles

  def simulate(particles, count) do
    tick(particles)
    |> simulate(count - 1)
  end

  def tick(particles) do
    particles
    |> Enum.map(&move_particle/1)
    |> remove_collisions
  end

  def remove_collisions(particles) do
    collided_particles =
      particles
      |> Enum.group_by(fn {p, _, _} -> p end)
      |> Enum.flat_map(fn {_, v} ->
        if length(v) >= 2, do: v, else: []
      end)

    Enum.reject(particles, &(&1 in collided_particles))
  end

  def move_particle({{px, py, pz}, {vx, vy, vz}, {ax, ay, az} = a}) do
    v = {vx, vy, vz} = {vx + ax, vy + ay, vz + az}
    p = {px + vx, py + vy, pz + vz}
    {p, v, a}
  end

  def parse(input) do
    %{"p" => position, "v" => velocity, "a" => acceleration} =
      Regex.named_captures(
        ~r{p=<(?<p>.*)>, v=<(?<v>.*)>, a=<(?<a>.*)>},
        input
      )

    [position, velocity, acceleration]
    |> Enum.map(fn x ->
      x
      |> String.split(",")
      |> Enum.map(&String.to_integer(&1))
      |> List.to_tuple()
    end)
    |> List.to_tuple()
  end

  def distance({x, y, z}) do
    abs(x) + abs(y) + abs(z)
  end
end
