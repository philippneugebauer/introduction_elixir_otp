# first compile and then call start_server
# afterwars, you can call "send :code_swap, :start" for sending messages
defmodule HotCodeSwap do

  def start_server do
    Process.register spawn(HotCodeSwap, :loop, [&HotCodeSwap.print/1]), :code_swap
  end

  def loop(function) do
    receive do
      {:swap, new_function} ->
        # do some state transformation if required
        loop(new_function)
      message ->
        function.(message)
        loop(function)
    end
  end

  def print(message) do
    IO.puts("print: #{message}")
  end

  def print2(message) do
    IO.puts("print2: #{message}")
  end

end

# http://www.unstablebuild.com/2016/03/18/hot-code-reload-in-elixir.html

# startserver() ->
#     register(server, spawn(swap_code, loop, [fun print/1])).
#
# % code upgrade with server ! {upgrade, fun swap_code:print2/1}.
# loop(Function) ->
# 	receive
# 		{upgrade, F} ->
# 			loop(F);
# 		Message ->
# 			Function(Message),
# 			loop(Function)
# 	end.
#
#
# print(Message) ->
# 	io:format("print: ~p\n",[Message]).
#
# print2(Message) ->
# 	io:format("print2: ~p\n",[Message]).