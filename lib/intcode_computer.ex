defmodule IntcodeComputer do
  def run(program, input \\ nil) do
    process(program, 0, input, [])
  end

  def process(program, instruction_pointer, input, output) do
    {opcode, param_values, destination_addr, increment} =
      parse_instruction(program, instruction_pointer)

    if opcode == 99 do
      {program, output}
    else
      {new_program, new_output} =
        calculate(program, opcode, param_values, destination_addr, input, output)

      process(new_program, instruction_pointer + increment, input, new_output)
    end
  end

  defp parse_instruction(program, instruction_pointer) do
    opcode = rem(Enum.at(program, instruction_pointer), 100)

    {_op, params, raw_destination, increment} = parse_opcode(opcode)
    num_params = Enum.count(params)
    destination =
      if raw_destination == nil,
        do: nil,
        else: Enum.at(program, instruction_pointer + raw_destination)

    explicit_modes =
      Enum.at(program, instruction_pointer)
      |> Integer.digits()
      |> Enum.reverse()
      |> List.delete_at(0)
      |> List.delete_at(0)

    modes =
      explicit_modes
      |> add_padding(num_params)
      |> Enum.map(fn x -> if x == 0, do: :position_mode, else: :immediate_mode end)

    param_values =
      modes
      |> Enum.zip(for i <- 1..num_params, do: Enum.at(program, instruction_pointer + i))
      |> Enum.map(fn x -> get_param_value(x, program) end)

    {opcode, param_values, destination, increment}
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
    end
  end

  # return {name, relative_param_pos, relative_destination_pos, increment}
  defp parse_opcode(opcode) do
    case opcode do
      1 -> {:plus, [1, 2], 3, 4}
      2 -> {:multiply, [1, 2], 3, 4}
      3 -> {:input, [], 1, 2}
      4 -> {:output, [1], nil, 2}
      99 -> {:halt, [], nil, nil}
    end
  end

  defp calculate(program, opcode, param_values, destination, input, output) do
    get_param = fn index -> Enum.at(param_values, index) end

    case opcode do
      1 -> {List.replace_at(program, destination, get_param.(0) + get_param.(1)), output}
      2 -> {List.replace_at(program, destination, get_param.(0) * get_param.(1)), output}
      3 -> {List.replace_at(program, destination, input), output}
      4 -> {program, output ++ [get_param.(0)]}
    end
  end
end
