defmodule FuelCalculatorTest do
  use ExUnit.Case
  doctest FuelCalculator

  test "calculates fuel requirement for single module" do
    assert FuelCalculator.module_fuel_requirement([100_756]) == 33583
  end

  test "calculates fuel requirement for multiple modules" do
    assert FuelCalculator.module_fuel_requirement([100_756, 1969, 14, 12]) == 34241
  end

  test "calculates total fuel requirement (fuel for module mass and fuel itself) for single module" do
    assert FuelCalculator.total_module_fuel_requirement([1969]) == 966
  end

  test "calculates total fuel requirement (fuel for module mass and fuel itself) for multiple modules" do
    assert FuelCalculator.total_module_fuel_requirement([1969, 100_756]) == 51312
  end
end
