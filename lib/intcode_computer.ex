defmodule IntcodeComputer do
  def run(program) do
    opcode_addrs = for i <- 0..(Enum.count(program) - 1), rem(i, 4) == 0, do: i

    Enum.reduce_while(
      opcode_addrs,
      program,
      fn addr, program -> process_instruction(addr, program) end
    )
  end

  defp process_instruction(instruction_pointer, program) do
    opcode = Enum.at(program, instruction_pointer)

    if instruction_pointer + 3 < Enum.count(program) and opcode != 99 do
      param1_addr = Enum.at(program, instruction_pointer + 1)
      param2_addr = Enum.at(program, instruction_pointer + 2)
      result_addr = Enum.at(program, instruction_pointer + 3)

      new_program =
        List.replace_at(
          program,
          result_addr,
          calculate(
            opcode,
            Enum.at(program, param1_addr),
            Enum.at(program, param2_addr)
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
