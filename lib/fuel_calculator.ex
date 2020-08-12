defmodule FuelCalculator do
  def module_fuel_requirment(module_masses) do
    module_masses
    |> Enum.map(&calc_fuel_requirement(&1))
    |> Enum.sum()
  end

  defp calc_fuel_requirement(x) do
    div(x, 3) - 2
  end
end