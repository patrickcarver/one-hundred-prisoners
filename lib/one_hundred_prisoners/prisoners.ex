defmodule OneHundredPrisoners.Prisoners do
  alias __MODULE__.{Counter, Regular}

  def new do
    1..99
    |> add_regulars()
    |> add_counter_at_index(100)
  end

  defp add_regulars(range) do
    Enum.reduce(range, %{}, fn index, acc -> Map.put(acc, index, Regular.new()) end)
  end

  defp add_counter_at_index(prisoners, index) do
    Map.put(prisoners, index, Counter.new())
  end
end
