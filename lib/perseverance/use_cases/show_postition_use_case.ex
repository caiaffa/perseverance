defmodule Perseverance.UseCases.ShowPositionUseCase do
  @repository Cachex

  def show() do
    @repository.get(:perseverance, :current_position)
  end
end
