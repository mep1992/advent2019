defmodule Instruction do
  defstruct type: nil, params: [], destination: nil, size: 0, opcode: nil
end

defmodule IntcodeComputer do
  def run(program, input \\ nil) do
    process(program, 0, input, [])
  end

  def process(program, instruction_pointer, input, output) do
    instruction = parse_instruction(program, instruction_pointer)
    get_param = fn index -> Enum.at(instruction.params, index) end
    update_program = fn destination, val -> List.replace_at(program, destination, val) end

    case instruction.type do
      :plus ->
        update_program.(instruction.destination, get_param.(0) + get_param.(1))
        |> process(instruction_pointer + instruction.size, input, output)

      :multiply ->
        update_program.(instruction.destination, get_param.(0) * get_param.(1))
        |> process(instruction_pointer + instruction.size, input, output)

      :input ->
        update_program.(instruction.destination, input)
        |> process(instruction_pointer + instruction.size, input, output)

      :output ->
        process(program, instruction_pointer + instruction.size, input, output ++ [get_param.(0)])

      :jump_if_true ->
        if get_param.(0) != 0 do
          process(program, get_param.(1), input, output)
        else
          process(program, instruction_pointer + instruction.size, input, output)
        end

      :jump_if_false ->
        if get_param.(0) == 0 do
          process(program, get_param.(1), input, output)
        else
          process(program, instruction_pointer + instruction.size, input, output)
        end

      :less_than ->
        if get_param.(0) < get_param.(1) do
          update_program.(instruction.destination, 1)
          |> process(instruction_pointer + instruction.size, input, output)
        else
          update_program.(instruction.destination, 0)
          |> process(instruction_pointer + instruction.size, input, output)
        end

      :equals ->
        if get_param.(0) == get_param.(1) do
          update_program.(instruction.destination, 1)
          |> process(instruction_pointer + instruction.size, input, output)
        else
          update_program.(instruction.destination, 0)
          |> process(instruction_pointer + instruction.size, input, output)
        end

      :halt ->
        {program, output}
    end
  end

  defp parse_instruction(program, instruction_pointer) do
    opcode = rem(Enum.at(program, instruction_pointer), 100)

    get_instruction(opcode)
    |> update_destination(program, instruction_pointer)
    |> update_param_values(program, instruction_pointer)
  end

  defp update_destination(instruction, program, instruction_pointer) do
    update_in(instruction.destination, fn d ->
      if d == nil, do: nil, else: Enum.at(program, instruction_pointer + instruction.destination)
    end)
  end

  defp update_param_values(instruction, program, instruction_pointer) do
    num_params = Enum.count(instruction.params)

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

    put_in(instruction.params, param_values)
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

  defp get_instruction(opcode) do
    case opcode do
      1 ->
        %Instruction{type: :plus, params: [1, 2], destination: 3, size: 4, opcode: 1}

      2 ->
        %Instruction{type: :multiply, params: [1, 2], destination: 3, size: 4, opcode: 2}

      3 ->
        %Instruction{type: :input, params: [], destination: 1, size: 2, opcode: 3}

      4 ->
        %Instruction{type: :output, params: [1], destination: nil, size: 2, opcode: 4}

      5 ->
        %Instruction{type: :jump_if_true, params: [1, 2], destination: nil, size: 3, opcode: 5}

      6 ->
        %Instruction{type: :jump_if_false, params: [1, 2], destination: nil, size: 3, opcode: 6}

      7 ->
        %Instruction{type: :less_than, params: [1, 2], destination: 3, size: 4, opcode: 7}

      8 ->
        %Instruction{type: :equals, params: [1, 2], destination: 3, size: 4, opcode: 8}

      99 ->
        %Instruction{type: :halt, params: [], destination: nil, size: nil, opcode: 99}
    end
  end
end
