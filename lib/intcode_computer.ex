defmodule IntcodeComputer do
  def run(program) do
    map_program = to_map(program)
    opcode = Map.fetch!(map_program, 0)
    param1_pos = Map.fetch!(map_program, 1)
    param2_pos = Map.fetch!(map_program, 2)
    result_pos = Map.fetch!(map_program, 3)

    result = Map.put(map_program, result_pos, calculate(opcode, Map.fetch!(map_program, param1_pos), Map.fetch!(map_program, param2_pos)))

    to_list(result)
  end

  defp calculate(opcode, param1, param2) do
    case opcode do
      1 -> param1 + param2
      2 -> param1 * param2
    end
  end

  def to_list(map) do
    Map.to_list(map)
    |> Enum.sort(fn {k1, _}, {k2, _} -> k1 <= k2 end)
    |> Enum.map(fn {_, v} -> v end)
  end

  def to_map(list) do
    to_map(Map.new(), 0, list)
  end

  defp to_map(map, index, [head | tail]) do
    Map.put(map, index, head)
    |> to_map(index + 1, tail)
  end

  defp to_map(map, _, []) do
    map
  end
end