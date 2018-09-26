defmodule Consumer do

  def accept do
    receive do
      {:message, number} ->
        IO.puts "received: #{number}"
        accept()
      _ ->
        accept()
    end
  end

end
