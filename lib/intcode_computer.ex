defmodule IntcodeComputer do
  def run(program) do
    map_program = to_map(program)
    opcode_indices = for i <- Map.keys(map_program), rem(i, 4) == 0, do: i

    Enum.reduce(opcode_indices, map_program, fn idx, map_program -> calculate_index(idx, map_program) end) |> to_list()
  end

  defp calculate_index(opcode_index, map_program) do
    opcode = Map.fetch!(map_program, opcode_index)
    if opcode != 99 do
      param1_pos = Map.fetch!(map_program, opcode_index + 1)
      param2_pos = Map.fetch!(map_program, opcode_index + 2)
      result_pos = Map.fetch!(map_program, opcode_index + 3)

      Map.put(
        map_program,
        result_pos,
        calculate(opcode, Map.fetch!(map_program, param1_pos), Map.fetch!(map_program, param2_pos))
      )
    else
      map_program
    end
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