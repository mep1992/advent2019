defmodule FuelCalculatorTest do
  use ExUnit.Case
  doctest FuelCalculator

  test "calculates fuel requirement for single module" do
    assert FuelCalculator.module_fuel_requirment([100756]) == 33583
  end

  test "calculates fuel requirement for multiple modules" do
    assert FuelCalculator.module_fuel_requirment([100756, 1969, 14, 12]) == 34241
  end
end
