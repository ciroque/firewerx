defmodule Firewerx.PingController do
  use Firewerx.Web, :controller

  def index(conn, _params) do
    render(conn, "pong.json", data: [])
  end
end
