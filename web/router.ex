defmodule Firewerx.Router do
  use Firewerx.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

#   Other scopes may use custom stacks.
   scope "/", Firewerx do
     pipe_through :api

     get "/", RootController, :index
     get "/ping", PingController, :index
     get "/led", LedController, :index
     post "/led/:value", LedController, :create
   end
end
