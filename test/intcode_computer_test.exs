defmodule IntcodeComputerTest do
  use ExUnit.Case
  doctest IntcodeComputer

  test "calculates correct result for simple addition program" do
    assert IntcodeComputer.run([1, 0, 0, 0, 99]) == {[2, 0, 0, 0, 99], []}
  end

  test "calculates correct result for two operation program with different parameter modes" do
    assert IntcodeComputer.run([1002, 4, 3, 4, 33]) == {[1002, 4, 3, 4, 99], []}
  end

  test "calculates correct result for two operation program with different parameter modes and negative numbers" do
    assert IntcodeComputer.run([1101, 100, -1, 4, 0]) == {[1101, 100, -1, 4, 99], []}
  end

  test "calculates correct result for simple multiplication program" do
    assert IntcodeComputer.run([2, 3, 0, 3, 99]) == {[2, 3, 0, 6, 99], []}
  end

  test "calculates correct result for multiplication program" do
    assert IntcodeComputer.run([2, 4, 4, 5, 99, 0]) == {[2, 4, 4, 5, 99, 9801], []}
  end

  test "calculates correct result for addition and multiplication operation program" do
    assert IntcodeComputer.run([1, 1, 1, 4, 99, 5, 6, 0, 99]) ==
             {[30, 1, 1, 4, 2, 5, 6, 0, 99], []}
  end

  @tag :wip
  test "calculates correct result for simple input program" do
    assert IntcodeComputer.run([3, 0, 4, 0, 99], 1) == {[1, 0, 4, 0, 99], [1]}
  end

  test "calculates correct result for jump program with position mode" do
    assert IntcodeComputer.run([3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9], 0) |> elem(1) == [0]
    assert IntcodeComputer.run([3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9], 3) |> elem(1) == [1]
  end

  test "calculates correct result for jump program with immediate mode" do
    assert IntcodeComputer.run([3,3,1105,-1,9,1101,0,0,12,4,12,99,1], 0) |> elem(1) == [0]
    assert IntcodeComputer.run([3,3,1105,-1,9,1101,0,0,12,4,12,99,1], 9) |> elem(1) == [1]
  end
end
