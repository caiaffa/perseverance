defmodule Perseverance.UseCases.StartPositionUseCase do
  @default_position %{"x" => 0, "y" => 0, "face" => "D"}
  @repository Cachex

  def create() do
    case @repository.put(:perseverance, :current_position, @default_position) do
      {:ok, true} -> @repository.get(:perseverance, :current_position)
      {:error, error} -> {:error, error}
    end
  end
end
