defmodule Day1 do
  def run() do
    module_masses = File.read!("lib/input.txt")

    String.split(module_masses, "\n")
    |> Enum.map(&String.to_integer(&1))
    |> FuelCalculator.module_fuel_requirment()
  end
end

IO.puts(Day1.run())
