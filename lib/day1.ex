defmodule Day1 do
  def part1() do
    module_masses = File.read!("lib/input.txt")

    String.split(module_masses, "\n")
    |> Enum.map(&String.to_integer(&1))
    |> FuelCalculator.module_fuel_requirement()
  end

  def part2() do
    module_masses = File.read!("lib/input.txt")

    String.split(module_masses, "\n")
    |> Enum.map(&String.to_integer(&1))
    |> FuelCalculator.total_module_fuel_requirement()
  end
end

IO.inspect(Day1.part1(), label: "part1")
IO.inspect(Day1.part2(), label: "part2")
