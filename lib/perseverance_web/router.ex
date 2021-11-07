defmodule PerseveranceWeb.Router do
  use PerseveranceWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", PerseveranceWeb do
    pipe_through :api

    scope "/v1" do
      get "/commands/start-position", ControlCenterController, :start
      get "/commands/show-position", ControlCenterController, :show
      post "/commands/move-position", ControlCenterController, :move
    end
  end
end
