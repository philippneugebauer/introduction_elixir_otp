defmodule Consumer do

  def accept do
    receive do
      number ->
        IO.puts "received: #{number}"
        accept()
    end
  end

end
