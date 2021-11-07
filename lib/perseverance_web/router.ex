defmodule PerseveranceWeb.Router do
  use PerseveranceWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", PerseveranceWeb do
    pipe_through :api

    scope "/v1" do
      get "/commands/restart-position", ControlCenterController, :restart
      get "/commands", ControlCenterController, :show
      post "/commands", ControlCenterController, :move
    end
  end
end
