defmodule Firewerks.PeriodicBlinker do

  alias ElixirALE.GPIO

  def start_link() do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    schedule_work()
    { :ok, state }
  end

  def handle_info(:work, state) do

    # Do the things here.
    {:ok, pid} = GPIO.start_link(4, :output)
    current_value = GPIO.read(pid)
    new_value = toggle_value(current_value)

    IO.puts("toggling LED: current_value: #{current_value}, new_value: #{new_value}")

    GPIO.write(pid, new_value)

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