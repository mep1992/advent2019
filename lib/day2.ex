defmodule Day2 do
  def part1() do
    module_masses = File.read!("lib/day2_input.txt")

    String.split(module_masses, ",")
    |> Enum.map(&String.to_integer(&1))
    |> IntcodeComputer.run()
  end
end

IO.puts("Day2 Output")
IO.inspect(Day2.part1(), label: "part1", limit: :infinity)