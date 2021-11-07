defmodule Perseverance.UseCases.MovePositionUseCase do
  alias Perseverance.ControlCenter

  @repository Cachex

  def move(commands) do
    with {:ok, current_position} <- @repository.get(:perseverance, :current_position),
         {:ok, new_position} <- ControlCenter.handle_command(commands, current_position) do
      @repository.put(:perseverance, :current_position, new_position)

      {:ok, Map.delete(new_position, "face")}
    else
      nil -> {:error, :position_null}
      {:error, _} -> {:error, :invalid_position}
    end
  end
end
