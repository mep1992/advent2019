defmodule PathIntersectionCalculatorTest do
  use ExUnit.Case
  doctest PathIntersectionCalculator

  test "calculates correct coordinate set for simple path" do
    assert PathIntersectionCalculator.coordinates(["R1", "U2", "L2", "D1"]) ==
             [{0, 0}, {1, 0}, {1, 1}, {1, 2}, {0, 2}, {-1, 2}, {-1, 1}]
  end

  test "calculates distance from origin" do
    assert PathIntersectionCalculator.distance_from_origin({3, 3}) == 6
    assert PathIntersectionCalculator.distance_from_origin({-3, -3}) == 6
  end

  test "calculates minimal intersection distance from origin" do
    assert PathIntersectionCalculator.min_intersection_distance(["R8", "U5", "L5", "D3"], [
             "U7",
             "R6",
             "D4",
             "L4"
           ]) == 6

    assert PathIntersectionCalculator.min_intersection_distance(
             ["R75", "D30", "R83", "U83", "L12", "D49", "R71", "U7", "L72"],
             ["U62", "R66", "U55", "R34", "D71", "R55", "D58", "R83"]
           ) == 159

    assert PathIntersectionCalculator.min_intersection_distance(
             ["R98", "U47", "R26", "D63", "R33", "U87", "L62", "D20", "R33", "U53", "R51"],
             ["U98", "R91", "D20", "R16", "D67", "R40", "U7", "R15", "U6", "R7"]
           ) == 135
  end

  test "calculates minimal intersection steps from origin" do
    assert PathIntersectionCalculator.min_intersection_steps(["R8", "U5", "L5", "D3"], [
             "U7",
             "R6",
             "D4",
             "L4"
           ]) == 30

    assert PathIntersectionCalculator.min_intersection_steps(
             ["R75", "D30", "R83", "U83", "L12", "D49", "R71", "U7", "L72"],
             ["U62", "R66", "U55", "R34", "D71", "R55", "D58", "R83"]
           ) == 610

    assert PathIntersectionCalculator.min_intersection_steps(
             ["R98", "U47", "R26", "D63", "R33", "U87", "L62", "D20", "R33", "U53", "R51"],
             ["U98", "R91", "D20", "R16", "D67", "R40", "U7", "R15", "U6", "R7"]
           ) == 410
  end
end
