defmodule Day2Test do
  use ExUnit.Case
  doctest Day1

  test "calculates value at position 0 correctly" do
    assert Day2.part1() |> List.first() == 4_462_686
  end

  test "calculates noun and verb correctly" do
    assert Day2.part2() |> (fn {noun, verb} -> 100 * noun + verb end).() == 5936
  end
end
