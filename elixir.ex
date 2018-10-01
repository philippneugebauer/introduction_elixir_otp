a = [%{true: 1, false: 2.0 }, {:ok, "success"}, fn x -> x + 1 end]

List.last(a).(1)

defmodule Example do

  def example([]) do
    []
  end

  def example(list), do: list

end
