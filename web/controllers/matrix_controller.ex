defmodule Firewerx.MatrixController do
  use Firewerx.Web, :controller

  def create(conn, %{"pattern" => pattern}) do
    IO.puts("AND THE PATTERN IS: #{pattern}")
    BicolorMatrix.draw_index(pattern)
    conn
    |> json(%{value: "yay"})
  end
end
