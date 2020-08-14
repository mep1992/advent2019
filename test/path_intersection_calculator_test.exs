defmodule PathIntersectionCalculatorTest do
  use ExUnit.Case
  doctest PathIntersectionCalculator

  test "calculates correct coordinate set for simple path" do
    assert PathIntersectionCalculator.coordinates(["R1", "U2", "L2", "D1"]) ==
             [{0, 0}, {1, 0}, {1, 1}, {1, 2}, {0, 2}, {-1, 2}, {-1, 1}] |> MapSet.new()
  end

  test "calculates intersections" do
    assert PathIntersectionCalculator.run(["R8", "U5", "L5", "D3"], ["U7", "R6", "D4", "L4"]) ==
             [{3, 3}, {6, 5}] |> MapSet.new()
  end
end
