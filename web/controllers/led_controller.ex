defmodule Firewerx.LedController do

  alias ElixirALE.GPIO

  {:ok, gpio17_output} = GPIO.start_link(17, :output)
  {:ok, gpio17_input} = GPIO.start_link(17, :input)

  def index(conn, _) do
    value = GPIO.read(gpio17_input)
    send_resp(conn, 200, %{ value: value })
  end

  def create(conn, %{"value" => value}) do
    new_value =  normalize_value(value)
    GPIO.write(gpio17_output, new_value)
    send_resp(conn, 200, %{new_value: new_value})
  end

  defp normalize_value(value) do
    value_i = value.to_i
    if (value_i == 1) do
      1
    else
      0
    end
  end
end