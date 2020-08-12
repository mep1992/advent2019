defmodule FuelCalculator do
  def module_fuel_requirement(module_masses) do
    module_masses
    |> Enum.map(&calc_fuel_requirement(&1))
    |> Enum.sum()
  end

  def total_module_fuel_requirement(module_masses) do
    module_masses
    |> Enum.map(&generate_fuel_requirements(&1))
    |> List.flatten()
    |> Enum.sum()
  end

  defp calc_fuel_requirement(x) do
    div(x, 3) - 2
  end

  defp generate_fuel_requirements(mass) do
    generate_fuel_requirements(mass, [])
  end

  defp generate_fuel_requirements(mass, calc_requirements) when mass > 0 do
    new_mass = calc_fuel_requirement(mass)

    if new_mass > 0 do
      generate_fuel_requirements(new_mass, [new_mass | calc_requirements])
    else
      generate_fuel_requirements(new_mass, calc_requirements)
    end
  end

  defp generate_fuel_requirements(_mass, calc_requirements) do
    calc_requirements
  end
end
