defmodule PerseveranceWeb.ControlCenterControllerTest do
  use PerseveranceWeb.ConnCase

  @valid_attrs %{
    movements: ["GE", "M", "M", "M", "GD", "M", "M"]
  }
  @invalid_attrs %{
    movements: ["x", "k", "t"]
  }

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "start" do
    test "should return initial position", %{conn: conn} do
      conn = get(conn, Routes.control_center_path(conn, :start))
      assert json_response(conn, 200) == %{"face" => "D", "x" => 0, "y" => 0}
    end
  end

  describe "move" do
    test "should return new position with valid attrs", %{conn: conn} do
      get(conn, Routes.control_center_path(conn, :start))

      conn = post(conn, Routes.control_center_path(conn, :move), @valid_attrs)
      assert json_response(conn, 200) == %{"x" => 2, "y" => 3}
    end

    test "should return error with invalid attrs", %{conn: conn} do
      get(conn, Routes.control_center_path(conn, :start))

      conn = post(conn, Routes.control_center_path(conn, :move), @invalid_attrs)

      assert json_response(conn, 400) == %{
               "error" =>
                 "Um movimento inválido foi detectado, infelizmente a sonda ainda não possui essa habilidade"
             }
    end

    test "should return error if initial position is empty", %{conn: conn} do
      Cachex.del(:perseverance, :current_position)
      conn = post(conn, Routes.control_center_path(conn, :move), @valid_attrs)
      assert json_response(conn, 400) == %{"error" => "Posição inicial não detectada"}
    end
  end

  describe "show" do
    test "should return current position", %{conn: conn} do
      get(conn, Routes.control_center_path(conn, :start))

      conn = get(conn, Routes.control_center_path(conn, :show))
      assert json_response(conn, 200) == %{"face" => "D", "x" => 0, "y" => 0}
    end
  end
end
