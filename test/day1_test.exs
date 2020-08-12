defmodule Day1Test do
  use ExUnit.Case
  doctest Day1

  test "calculates correct fuel requirement for modules in input" do
    assert Day1.part1() == 3_328_306
  end

  test "calculates correct total fuel requirement for modules in input" do
    assert Day1.part2() == 4_989_588
  end
end
