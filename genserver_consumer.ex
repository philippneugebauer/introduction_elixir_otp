defmodule GenserverConsumer do
  use GenServer

  def start_link do
    {:ok, _pid} = GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def handle_cast({:message, number}, []) do
    IO.puts "received: #{number}"
    {:noreply, []}
  end

  def init(_) do
    {:ok, []}
  end
end