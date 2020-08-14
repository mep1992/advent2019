defmodule Day3Test do
  use ExUnit.Case
  doctest Day3

  test "calculates correct minimal intersection distance to origin" do
    assert Day3.part1() == 806
  end
end
