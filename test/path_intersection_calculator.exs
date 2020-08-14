defmodule PathIntersectionCalculatorTest do
  use ExUnit.Case
  doctest PathIntersectionCalculator

  test "calculates correct coordinate set for simple path" do
    assert PathIntersectionCalculator.coordinate_set(["R1", "U2", "L2", "D1"]) == [
             {0, 0},
             {1, 0},
             {1, 1},
             {1, 2},
             {0, 2},
             {-1, 2},
             {-1, 1}
           ]
  end
end
