defmodule PerseveranceWeb.Router do
  use PerseveranceWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", PerseveranceWeb do
    pipe_through :api
  end
end
