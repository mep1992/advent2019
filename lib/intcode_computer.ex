defmodule IntcodeComputer do
  def run(program, input \\ nil) do
    process(program, 0, input, [])
  end

  def process(program, instruction_pointer, input, output) do
    # IO.inspect(output, label: "output=")
    {opcode, param_values} = parse_instruction(program, instruction_pointer)

    if opcode == 99 do
      {program, output}
    else
      {new_program, new_output} = calculate(program, opcode, param_values, input, output)
      process(new_program, instruction_pointer + Enum.count(param_values) + 1, input, new_output)
    end
  end

  defp parse_instruction(program, instruction_pointer) do
    # IO.puts("~~~~~~~~~~~~~~~~\n")
    # IO.inspect(instruction_pointer, label: "instruction_pointer=")
    # IO.inspect(program, label: "program=")

    opcode = rem(Enum.at(program, instruction_pointer), 100)
    # IO.inspect(opcode, label: "opcode=")

    num_params = get_num_params(opcode)
    # IO.inspect(num_params, label: "num_params=")

    explicit_modes =
      Enum.at(program, instruction_pointer)
      |> Integer.digits()
      |> Enum.reverse()
      |> List.delete_at(0)
      |> List.delete_at(0)

    # IO.inspect(explicit_modes, label: "explicit_modes=")

    modes =
      explicit_modes
      |> add_padding(num_params)
      |> Enum.map(fn x -> if x == 0, do: :position_mode, else: :immediate_mode end)
      |> (fn x -> List.replace_at(x, Enum.count(x) - 1, :output_addr) end).()

    # IO.inspect(modes, label: "modes=")

    param_values =
      modes
      |> Enum.zip(for i <- 1..num_params, do: Enum.at(program, instruction_pointer + i))
      |> Enum.map(fn x -> get_param_value(x, program) end)

    {opcode, param_values}
  end

  defp add_padding(list, desired_length) do
    if Enum.count(list) == desired_length,
      do: list,
      else: add_padding(list ++ [0], desired_length)
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

  defp calculate(program, opcode, param_values, input, output) do
    get_param = fn index -> Enum.at(param_values, index) end

    case opcode do
      1 -> {List.replace_at(program, get_param.(2), get_param.(0) + get_param.(1)), output}
      2 -> {List.replace_at(program, get_param.(2), get_param.(0) * get_param.(1)), output}
      3 -> {List.replace_at(program, get_param.(0), input), output}
      4 -> {program, output ++ [Enum.fetch!(program, get_param.(0))]}
    end
  end
end
