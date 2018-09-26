defmodule SupervisorProducer do
  use Supervisor

  def start_link do
    {:ok, _pid} = Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def message_consumer(number) do
    GenServer.cast(GenserverConsumer, {:message, number})
  end

  def init(_) do
    supervise [worker(GenserverConsumer, [], restart: :transient)], strategy: :one_for_one
  end
end