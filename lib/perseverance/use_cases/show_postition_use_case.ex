defmodule Perseverance.UseCases.ShowPositionUseCase do
  @moduledoc false
  @repository Cachex

  def show do
    @repository.get(:perseverance, :current_position)
  end
end
