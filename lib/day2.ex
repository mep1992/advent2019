defmodule Day2 do
  def part1() do
    get_memory()
    |> List.replace_at(1, 12)
    |> List.replace_at(2, 2)
    |> IntcodeComputer.run()
  end

  def part2() do
    memory = get_memory()

    inputs = for noun <- 0..99, verb <- 0..99, do: {noun, verb}

    Enum.find(
      inputs,
      fn {noun, verb} ->
        memory
        |> List.replace_at(1, noun)
        |> List.replace_at(2, verb)
        |> IntcodeComputer.run()
        |> List.first() == 19_690_720
      end
    )
  end

  defp get_memory do
    File.read!("lib/day2_input.txt")
    |> String.split(",")
    |> Enum.map(&String.to_integer(&1))
  end
end

IO.puts("Day2 Output")
IO.inspect(Day2.part1(), label: "part1", limit: :infinity)
IO.inspect(Day2.part2(), label: "part2")
