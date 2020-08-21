defmodule Day5 do
  def part1() do
    IntcodeComputer.run(get_input(), 1) |> elem(1)
  end

  defp get_input do
    File.read!("lib/day5_input.txt")
    |> String.split(",")
    |> Enum.map(&String.to_integer(&1))
  end
end

IO.puts("Day5 Output")
IO.inspect(Day5.part1(), label: "part1", limit: :infinity)
