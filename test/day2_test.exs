defmodule Day2Test do
  use ExUnit.Case
  doctest Day1

  test "calculates value at position 0 correctly" do
    assert Day2.part1() |> List.first() == 4_462_686
  end
end
