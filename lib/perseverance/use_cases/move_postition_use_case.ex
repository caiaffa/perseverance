defmodule Perseverance.UseCases.MovePositionUseCase do
  @moduledoc false
  alias Perseverance.ControlCenter

  @repository Cachex

  def move(commands) do
    with {:ok, true} <- @repository.exists?(:perseverance, :current_position),
         {:ok, current_position} <- @repository.get(:perseverance, :current_position),
         {:ok, new_position} <- ControlCenter.handle_command(commands, current_position) do
      @repository.put(:perseverance, :current_position, new_position)

      {:ok, Map.delete(new_position, "face")}
    else
      {:ok, false} ->
        {:error, :position_null}

      {:error, _} ->
        IO.inspect("DSADSADSA")
        {:error, :invalid_position}
    end
  end
end
