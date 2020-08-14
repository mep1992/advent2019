defmodule PathIntersectionCalculator do
  def min_intersection_distance(path1, path2) do
    MapSet.intersection(coordinates(path1), coordinates(path2))
    |> MapSet.delete({0, 0})
    |> Enum.map(fn coordinate -> distance_from_origin(coordinate) end)
    |> Enum.min()
  end

  def distance_from_origin({x, y}) do
    abs(0 - x) + abs(0 - y)
  end

  def coordinates(path) do
    path
    |> Enum.reduce([{0, 0}], fn section, coordinates -> enumerate(section, coordinates) end)
    |> MapSet.new()
  end

  defp enumerate(section, coordinates) do
    ref_coordinates = List.last(coordinates)
    direction = String.first(section)

    magnitude =
      section |> (fn s -> String.slice(s, 1..String.length(s)) end).() |> String.to_integer()

    coordinates ++ new_coordinates(direction, magnitude, ref_coordinates)
  end

  defp new_coordinates(direction, magnitude, {ref_x, ref_y}) do
    case direction do
      "R" -> for i <- 1..magnitude, do: {ref_x + i, ref_y}
      "L" -> for i <- 1..magnitude, do: {ref_x - i, ref_y}
      "U" -> for i <- 1..magnitude, do: {ref_x, ref_y + i}
      "D" -> for i <- 1..magnitude, do: {ref_x, ref_y - i}
    end
  end
end
