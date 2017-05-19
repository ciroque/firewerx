defmodule Firewerx.LedController do
  use Firewerx.Web, :controller

  alias ElixirALE.GPIO

  def index(conn, _params) do
    {:ok, read_pid } = GPIO.start_link(6, :input)
    value = GPIO.read(read_pid)
    GPIO.release(read_pid)
    IO.puts("LedController::index #{value}")
    json conn, %{ value: value }
  end

  def create(conn, %{"value" => 0}) do
    json conn, %{ value: set_led_state(0) }
  end

  def create(conn, %{"value" => 1}) do
    json conn, %{ value: set_led_state(1) }
  end

  defp set_led_state(value) do
    {:ok, write_pid} = GPIO.start_link(6, :output)
    GPIO.write(write_pid, value)
    GPIO.release(write_pid)
  end
end
