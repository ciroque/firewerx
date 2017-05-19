defmodule Firewerks.PeriodicBlinker do

  alias ElixirALE.GPIO

  def start_link() do
    {:ok, read_pid } = GPIO.start_link(5, :input)
    {:ok, write_pid } = GPIO.start_link(5, :output)
    GenServer.start_link(__MODULE__, %{ read_pid: read_pid, write_pid: write_pid })
  end

  def init(state) do
    schedule_work()
    { :ok, state }
  end

  def handle_info(:work, state) do

    current_value = GPIO.read(state.read_pid)
    new_value = toggle_value(current_value)

    IO.puts("toggling LED: current_value: #{current_value}, new_value: #{new_value}")

    GPIO.write(state.write_pid, new_value)

    schedule_work()
    {:noreply, state}
  end

  def schedule_work() do
    Process.send_after(self(), :work, 1 * 1000)
  end

  def terminate(reason, state) do
    IO.puts("REASON: #{reason}, STATE: #{state}")
    {:ok, state}
  end

  defp toggle_value(value) do
    if (value == 1) do
      0
    else
      1
    end
  end
end
