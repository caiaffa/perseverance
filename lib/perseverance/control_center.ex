defmodule Perseverance.ControlCenter do
  @moduledoc false

  @directions %{
    "GE" => %{"D" => "C", "C" => "E", "E" => "B", "B" => "D"},
    "GD" => %{"D" => "B", "B" => "E", "E" => "C", "C" => "D"}
  }

  @size_x 0..4
  @size_y 0..4

  def handle_command(commands, start_position) do
    with {:ok, current_position} <- get_each_command(commands, start_position),
         {:ok, _} <- validate_current_position(current_position) do
      {:ok, current_position}
    end
  end

  defp get_each_command([], current_position), do: {:ok, current_position}

  defp get_each_command(commands, current_position) do
    [command | tail_commands] = commands

    with {:ok, new_position} <- execute_command(command, current_position) do
      get_each_command(tail_commands, new_position)
    end
  end

  defp validate_current_position(current_position) do
    case current_position["x"] in @size_x and current_position["y"] in @size_y do
      true -> {:ok, current_position}
      false -> {:error, current_position}
    end
  end

  defp execute_command("GE" = command, current_position) do
    {:ok, Map.put(current_position, "face", @directions[command][current_position["face"]])}
  end

  defp execute_command("GD" = command, current_position) do
    {:ok, Map.put(current_position, "face", @directions[command][current_position["face"]])}
  end

  defp execute_command("M" = _command, current_position) do
    case current_position["face"] do
      "C" -> {:ok, Map.update(current_position, "y", 0, &(&1 + 1))}
      "B" -> {:ok, Map.update(current_position, "y", 0, &(&1 - 1))}
      "D" -> {:ok, Map.update(current_position, "x", 0, &(&1 + 1))}
      "E" -> {:ok, Map.update(current_position, "x", 0, &(&1 - 1))}
    end
  end

  defp execute_command(_command, current_position),
    do: {:error, current_position}
end
