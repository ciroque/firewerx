defmodule Firewerx.RootController do
  use Firewerx.Web, :controller

  def index(conn, _params) do
    render(conn, "index.json", json: [])
  end
end
