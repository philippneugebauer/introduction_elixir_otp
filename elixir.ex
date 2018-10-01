a = [1, 2.0, true, false, {:ok, "success"}, fn x -> x + 1 end]

List.last(a).(1)

defmodule Example do

  def example([]) do
    []
  end

  def example(list), do: list

end
