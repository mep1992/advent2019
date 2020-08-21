defmodule IntcodeComputer do
  def run(program, _input \\ nil) do
    process(0, program)
  end

  def process(instruction_pointer, program) do
    opcode = rem(Enum.at(program, instruction_pointer), 100)
    num_params = get_num_params(opcode)

    modes =
      div(Enum.at(program, instruction_pointer), 100)
      |> Integer.digits()
      |> Enum.reverse()
      |> (fn x -> Enum.concat(x, for(_ <- 0..(num_params - Enum.count(x) - 1), do: 0)) end).()
      |> Enum.map(fn x -> if x == 0, do: :position_mode, else: :immediate_mode end)
      |> (fn x -> List.replace_at(x, Enum.count(x) - 1, :output_addr) end).()

    if opcode == 99 do
      program
    else
      param_values =
        modes
        |> Enum.zip(for i <- 1..num_params, do: Enum.at(program, instruction_pointer + i))
        |> Enum.map(fn x -> get_param_value(x, program) end)

      new_program = calculate(program, opcode, param_values)

      process(instruction_pointer + num_params + 1, new_program)
    end
  end

  defp get_param_value(mode_param_pair, program) do
    case mode_param_pair do
      {:position_mode, addr} -> Enum.at(program, addr)
      {:immediate_mode, val} -> val
      {:output_addr, val} -> val
    end
  end

  defp get_num_params(opcode) do
    case opcode do
      1 -> 3
      2 -> 3
      3 -> 1
      4 -> 1
      99 -> 0
    end
  end

  defp calculate(program, opcode, param_values) do
    get_param = fn index -> Enum.at(param_values, index) end

    case opcode do
      1 -> List.replace_at(program, get_param.(2), get_param.(0) + get_param.(1))
      2 -> List.replace_at(program, get_param.(2), get_param.(0) * get_param.(1))
    end
  end
end
