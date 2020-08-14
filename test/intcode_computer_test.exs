defmodule IntcodeComputerTest do
  use ExUnit.Case
  doctest IntcodeComputer

  test "calculates correct result for simple addition program" do
    assert IntcodeComputer.run([1, 0, 0, 0, 99]) == [2, 0, 0, 0, 99]
  end

  test "calculates correct result for simple multiplication program" do
    assert IntcodeComputer.run([2, 3, 0, 3, 99]) == [2, 3, 0, 6, 99]
  end

  test "calculates correct result for multiplication program" do
    assert IntcodeComputer.run([2, 4, 4, 5, 99, 0]) == [2, 4, 4, 5, 99, 9801]
  end

  test "calculates correct result for two operation program" do
    assert IntcodeComputer.run([1, 1, 1, 4, 99, 5, 6, 0, 99]) == [30, 1, 1, 4, 2, 5, 6, 0, 99]
  end
end
