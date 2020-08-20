defmodule IntcodeComputer do
  def run(program) do
    process(0, program)
  end

  def process(instruction_pointer, program) do
    opcode = Enum.at(program, instruction_pointer)

    if opcode == 99 do
      program
    else
      num_params = get_num_params(opcode)
      param_addrs = for i <- 1..num_params, do: Enum.at(program, instruction_pointer + i)
      param_values = Enum.map(param_addrs, fn addr -> Enum.at(program, addr) end)
      result_addr = List.last(param_addrs)

      new_program =
        List.replace_at(
          program,
          result_addr,
          calculate(opcode, param_values)
        )

      process(instruction_pointer + num_params + 1, new_program)
    end
  end

  defp get_num_params(opcode) do
    case opcode do
      1 -> 3
      2 -> 3
      99 -> 0
    end
  end

  defp calculate(opcode, param_values) do
    case opcode do
      1 -> Enum.at(param_values, 0) + Enum.at(param_values, 1)
      2 -> Enum.at(param_values, 0) * Enum.at(param_values, 1)
    end
  end
end
