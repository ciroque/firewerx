defmodule Firewerx.RootView do
  use Firewerx.Web, :view

  def render("index.json", %{json: json}) do
    %{data: json}
  end
end
