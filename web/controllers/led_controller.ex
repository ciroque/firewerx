defmodule Firewerx.LedController do
  use Firewerx.Web, :controller

  alias ElixirALE.GPIO

  def index(conn, _) do
    {:ok, read_pid } = GPIO.start_link(17, :output)
    value = GPIO.read(read_pid)
    GPIO.release(read_pid)
    send_resp(conn, 200, %{ value: value })
  end

  def create(conn, %{"value" => value}) do
    new_value =  normalize_value(value)
    {:ok, write_pid} = GPIO.start_link(17, :input)
    GPIO.write(write_pid, new_value)
    GPIO.release(write_pid)
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