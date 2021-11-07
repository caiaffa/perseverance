defmodule Perseverance.UseCases.StartPositionUseCase do
  @moduledoc false
  @default_position %{"x" => 0, "y" => 0, "face" => "D"}
  @repository Cachex

  def create do
    @repository.put(:perseverance, :current_position, @default_position)
    @repository.get(:perseverance, :current_position)
  end
end
