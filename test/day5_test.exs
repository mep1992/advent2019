defmodule Day5Test do
  use ExUnit.Case
  doctest Day5

  test "calculates diagnostic code correctly" do
    assert Day5.part1() |> List.last() == 14_155_342
  end

  test "calculates TEST diagnostic code correctly" do
    assert Day5.part2() |> List.last() == 8_684_145
  end
end
