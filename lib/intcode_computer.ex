defmodule IntcodeComputer do
  def run(program) do
    opcode_indices = for i <- 0..(Enum.count(program) - 1), rem(i, 4) == 0, do: i

    Enum.reduce_while(
      opcode_indices,
      program,
      fn idx, program -> calculate_index(idx, program) end
    )
  end

  defp calculate_index(opcode_index, program) do
    opcode = Enum.at(program, opcode_index)

    if opcode_index + 3 < Enum.count(program) and opcode != 99 do
      param1_pos = Enum.at(program, opcode_index + 1)
      param2_pos = Enum.at(program, opcode_index + 2)
      result_pos = Enum.at(program, opcode_index + 3)

      new_program =
        List.replace_at(
          program,
          result_pos,
          calculate(
            opcode,
            Enum.at(program, param1_pos),
            Enum.at(program, param2_pos)
          )
        )

      {:cont, new_program}
    else
      {:halt, program}
    end
  end

  defp calculate(opcode, param1, param2) do
    case opcode do
      1 -> param1 + param2
      2 -> param1 * param2
    end
  end
end
