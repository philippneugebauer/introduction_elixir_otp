# load file with c "producer.ex" into iex
# requires also loading c "consumer.ex"
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
      number ->
        send :consumer, number
        send()
      _ ->
        send()
    end
  end

  def producer_send(number) do
    send :producer, number
  end

end
