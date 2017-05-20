defmodule Firewerx.MatrixController do
  use Firewerx.Web, :controller

  def create(conn, %{"pattern" => pattern, "brightness" => brightness}) do
    conn
    |> json(%{value: render_pattern(pattern, brightness)})
  end
  
  def create(conn, %{"pattern" => pattern}) do
    brightness = :rand.uniform(15)
    conn
    |> json(%{value: render_pattern(pattern, brightness)})
  end

  defp render_pattern(pattern, brightness) do
    BicolorMatrix.initialize()
    BicolorMatrix.set_brightness(brightness)
    BicolorMatrix.draw_index(pattern)
    %{ pattern: pattern, brightness: brightness }
  end

end
