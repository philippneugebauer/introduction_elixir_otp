# load file with c "supervisor_producer.ex" into iex
# requires also loading c "genserver_consumer.ex"
# then you can send messages with SupervisorProducer.message_consumer(5)
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