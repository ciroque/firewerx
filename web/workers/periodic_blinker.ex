defmodule Firewerks.PeriodicBlinker do

  def start_link() do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    schedule_work()
    { :ok, state }
  end

  def handle_info(:work, state) do

    # Do the things here.

    IO.puts("PeriodicBlinker.handle_work")

    schedule_work()
    {:noreply, state}
  end

  def schedule_work() do
    Process.send_after(self(), :work, 2 * 1000)
  end

  def terminate(reason, state) do
    IO.puts("")
    {:ok, state}
  end
end