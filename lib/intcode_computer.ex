defmodule Instruction do
  defstruct type: nil, params: [], destination: nil, next: 0

  def create(program, instruction_pointer) do
    opcode = rem(Enum.at(program, instruction_pointer), 100)

    {type, relative_params, relative_destination, size} = get_instruction_details(opcode)

    %Instruction{
      type: type,
      params: get_params(program, instruction_pointer, relative_params),
      destination: get_destination(program, instruction_pointer, relative_destination),
      next: instruction_pointer + size
    }
  end

  # return {name, relative_params, relative_destination, size}
  defp get_instruction_details(1), do: {:plus, [1, 2], 3, 4}
  defp get_instruction_details(2), do: {:multiply, [1, 2], 3, 4}
  defp get_instruction_details(3), do: {:input, [], 1, 2}
  defp get_instruction_details(4), do: {:output, [1], nil, 2}
  defp get_instruction_details(5), do: {:jump_if_true, [1, 2], nil, 3}
  defp get_instruction_details(6), do: {:jump_if_false, [1, 2], nil, 3}
  defp get_instruction_details(7), do: {:less_than, [1, 2], 3, 4}
  defp get_instruction_details(8), do: {:equals, [1, 2], 3, 4}
  defp get_instruction_details(99), do: {:halt, [], nil, 1}

  defp get_destination(_, _, nil), do: nil

  defp get_destination(program, instruction_pointer, relative_destination),
    do: Enum.at(program, instruction_pointer + relative_destination)

  defp get_params(program, instruction_pointer, relative_params) do
    num_params = Enum.count(relative_params)

    Enum.at(program, instruction_pointer)
    |> Integer.digits()
    |> Enum.reverse()
    |> List.delete_at(0)
    |> List.delete_at(0)
    |> add_padding(num_params)
    |> Enum.map(fn x -> if x == 0, do: :position_mode, else: :immediate_mode end)
    |> Enum.zip(for i <- 1..num_params, do: Enum.at(program, instruction_pointer + i))
    |> Enum.map(fn x -> get_param_value(x, program) end)
  end

  defp add_padding(list, desired_length) do
    if Enum.count(list) == desired_length,
      do: list,
      else: add_padding(list ++ [0], desired_length)
  end

  defp get_param_value({:position_mode, addr}, program), do: Enum.at(program, addr)
  defp get_param_value({:immediate_mode, val}, _), do: val
end

defmodule IntcodeComputer do
  def run(program, input \\ nil) do
    process(program, 0, input, [])
  end

  def process(program, instruction_pointer, input, output) do
    instruction = Instruction.create(program, instruction_pointer)
    get_param = fn index -> Enum.at(instruction.params, index) end
    update_program = fn destination, val -> List.replace_at(program, destination, val) end

    case instruction.type do
      :plus ->
        update_program.(instruction.destination, get_param.(0) + get_param.(1))
        |> process(instruction.next, input, output)

      :multiply ->
        update_program.(instruction.destination, get_param.(0) * get_param.(1))
        |> process(instruction.next, input, output)

      :input ->
        update_program.(instruction.destination, input)
        |> process(instruction.next, input, output)

      :output ->
        process(program, instruction.next, input, output ++ [get_param.(0)])

      :jump_if_true ->
        if get_param.(0) != 0 do
          process(program, get_param.(1), input, output)
        else
          process(program, instruction.next, input, output)
        end

      :jump_if_false ->
        if get_param.(0) == 0 do
          process(program, get_param.(1), input, output)
        else
          process(program, instruction.next, input, output)
        end

      :less_than ->
        if get_param.(0) < get_param.(1) do
          update_program.(instruction.destination, 1)
          |> process(instruction.next, input, output)
        else
          update_program.(instruction.destination, 0)
          |> process(instruction.next, input, output)
        end

      :equals ->
        if get_param.(0) == get_param.(1) do
          update_program.(instruction.destination, 1)
          |> process(instruction.next, input, output)
        else
          update_program.(instruction.destination, 0)
          |> process(instruction.next, input, output)
        end

      :halt ->
        {program, output}
    end
  end
end
