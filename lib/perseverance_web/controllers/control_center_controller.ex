defmodule PerseveranceWeb.ControlCenterController do
  @moduledoc false

  use PerseveranceWeb, :controller

  alias Perseverance.UseCases.{MovePositionUseCase, ShowPositionUseCase, StartPositionUseCase}

  def start(conn, _params) do
    case StartPositionUseCase.create() do
      {:ok, current_position} ->
        conn
        |> put_status(200)
        |> json(current_position)

      {:error, _} ->
        conn
        |> put_status(500)
        |> json(%{"error" => "Erro interno"})
    end
  end

  def show(conn, _param) do
    case ShowPositionUseCase.show() do
      {:ok, nil} ->
        conn
        |> put_status(400)
        |> json(%{"error" => "Posição inicial não detectada"})

      {:ok, current_position} ->
        conn
        |> put_status(200)
        |> json(current_position)
    end
  end

  def move(conn, %{"movements" => movements}) do
    case MovePositionUseCase.move(movements) do
      {:ok, current_position} ->
        conn
        |> put_status(200)
        |> json(current_position)

      {:error, :invalid_position} ->
        conn
        |> put_status(400)
        |> json(%{
          "error" =>
            "Um movimento inválido foi detectado, infelizmente a sonda ainda não possui essa habilidade"
        })

      {:error, :position_null} ->
        conn
        |> put_status(400)
        |> json(%{"error" => "Posição inicial não detectada"})
    end
  end
end
