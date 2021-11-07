defmodule Perseverance.ControlCenterTest do
  use ExUnit.Case

  alias Perseverance.ControlCenter

  @valid_position %{"x" => 0, "y" => 0, "face" => "D"}
  @valid_commands ["GE", "M", "M", "M", "GD", "M", "M"]

  @invalid_commands ["x", "k", "t"]
  @invalid_position %{"x" => 0}

  describe "handle_command/2" do
    test "should return new position with valid params" do
      assert ControlCenter.handle_command(@valid_commands, @valid_position) ==
               {:ok, %{"face" => "D", "x" => 2, "y" => 3}}
    end

    test "should return error with invalid commands" do
      assert ControlCenter.handle_command(@invalid_commands, @valid_position) ==
               {:error, @valid_position}
    end

    test "should return error with invalid position" do
      assert ControlCenter.handle_command(@valid_commands, @invalid_position) ==
               {:error, @invalid_position}
    end

    test "should return error with invalid commands and invalid position" do
      assert ControlCenter.handle_command(@invalid_commands, @invalid_position) ==
               {:error, @invalid_position}
    end
  end
end
