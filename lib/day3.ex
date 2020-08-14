defmodule Day3 do
  def part1() do
    [wire_path1, wire_path2] =
      File.read!("lib/day3_input.txt")
      |> String.split("\n")

    PathIntersectionCalculator.min_intersection_distance(
      String.split(wire_path1, ","),
      String.split(wire_path2, ",")
    )
  end

  def part2() do
    [wire_path1, wire_path2] =
      File.read!("lib/day3_input.txt")
      |> String.split("\n")

    PathIntersectionCalculator.min_intersection_steps(
      String.split(wire_path1, ","),
      String.split(wire_path2, ",")
    )
  end
end

IO.puts("Day3 Output")
IO.inspect(Day3.part1(), label: "part1")
IO.inspect(Day3.part2(), label: "part2")
