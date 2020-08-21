defmodule Day5Test do
  use ExUnit.Case
  doctest Day5

  test "calculates diagnostic code correctly" do
    assert Day5.part1() |> List.last() == 14155342
  end
end
