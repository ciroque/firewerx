defmodule Firewerx.PingView do
  use Firewerx.Web, :view

  def render("pong.json", %{data: _}) do
    :pong
  end
end
