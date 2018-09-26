# load file with c "producer.ex" into iex
# requires also loading c "consumer.ex"
# then you can send messages with Producer.message_consumer(5)
defmodule Producer do

  def init do
    Process.register spawn(Producer, :send, []), :producer
    send :producer, :start
  end

  def send do
    Process.flag :trap_exit, true

    receive do
      :start ->
        Process.register spawn_link(Consumer, :accept, []), :consumer
        send()
      {:EXIT, _from, _reason} ->
        Process.unlink :consumer
        Process.unregister :consumer
        send :producer, :start
        send()
      _ ->
        send()
    end
  end

  def message_consumer(number) do
    send :consumer, {:message, number}
  end

end
