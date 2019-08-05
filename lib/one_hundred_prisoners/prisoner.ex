defmodule OneHundredPrisoners.Prisoner do
  alias __MODULE__.{Counter, Regular}

  def create_prisoners() do
    2..100
    |> add_regulars()
    |> add_counter_at_index(1)
  end

  def visit_room(:light_bulb_off, %Counter{} = prisoner) do
    new_prisoner = Counter.increment(prisoner)
    {:light_bulb_on, new_prisoner}
  end

  def visit_room(:light_bulb_on, %Regular{found_light_on_once: false}) do
    {:light_bulb_off, %Regular{found_light_on_once: true}}
  end

  def visit_room(light_bulb, prisoner) do
    {light_bulb, prisoner}
  end

  defp add_regulars(range) do
    Enum.reduce(range, %{}, fn index, acc -> Map.put(acc, index, Regular.new()) end)
  end

  defp add_counter_at_index(prisoners, index) do
    Map.put(prisoners, index, Counter.new())
  end
end
