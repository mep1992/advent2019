defmodule Day1Test do
  use ExUnit.Case
  doctest Day1

  test "calculates correct fuel requirement modules in input" do
    assert Day1.run() == 3328306
  end
end