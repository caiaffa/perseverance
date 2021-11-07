defmodule Perseverance.ControlCenter do
  @directions %{
    "GE" => %{"D" => "C", "C" => "E", "E" => "B", "B" => "D"},
    "GD" => %{"D" => "B", "B" => "E", "E" => "C", "C" => "D"}
  }

  @size_x 0..4
  @size_y 0..4

  def handle_command(commands, current_position) do
    with {:ok, _} <- get_each_command(commands, "D", current_position), {:ok, _} <- validate_current_position(current_position) do
      {:ok, current_position}
    end
  end

  defp get_each_command([], _direction, current_position), do: {:ok, current_position}

  defp get_each_command(commands, direction, current_position) do
    [command | tail_commands] = commands
    with {:ok, new_direction, new_position} <- execute_command(command, direction, current_position) do
      get_each_command(tail_commands, new_direction, new_position)
    end

  end

  defp validate_current_position(current_position) do
    case current_position["x"] in @size_x and current_position["y"] in @size_y do
      true -> {:ok, current_position}
      false -> {:error, current_position}
    end
  end

  defp execute_command("GE" = command, direction, current_position) do
    {:ok, @directions[command][direction], current_position}
  end

  defp execute_command("GD" = command, direction, current_position) do
    {:ok, @directions[command][direction], current_position}
  end

  defp execute_command("M" = _command, direction, current_position) do
    case direction do
      "C" -> {:ok, direction, Map.update(current_position, "y", 0, &(&1 + 1))}
      "B" -> {:ok ,direction, Map.update(current_position, "y", 0, &(&1 - 1))}
      "D" -> {:ok, direction, Map.update(current_position, "x", 0, &(&1 + 1))}
      "E" -> {:ok, direction, Map.update(current_position, "x", 0, &(&1 - 1))}
    end
  end

  defp execute_command(_command, _direction, current_position), do: {:error, current_position}

end
