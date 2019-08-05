defmodule OneHundredPrisoners do

  defstruct ~w[light_bulb prisoners current_visit ids_of_visited]a

  alias __MODULE__.Prisoner
  alias __MODULE__.Prisoner.Counter

  def run do
    new() |> visit()
  end

  defp new do
    %__MODULE__{
      light_bulb: :light_bulb_off,
      prisoners: Prisoner.create_prisoners(),
      ids_of_visited: MapSet.new(),
      current_visit: 1
    }
  end

  defp visit(state) do
    state
    |> random_prisoner_with_id()
    |> visit_room()
    |> verdict_or_visit()
  end

  defp random_prisoner_with_id(state) do
    {id, prisoner} = Enum.random(state.prisoners)
    {state, id, prisoner}
  end

  defp visit_room({state, id, prisoner}) do
    {new_light_bulb, new_prisoner} = Prisoner.visit_room(state.light_bulb, prisoner)
    {state, new_prisoner, new_light_bulb, id}
  end

  defp verdict_or_visit({state, %Counter{times_on_to_off: 100}, _light_bulb, _id}) do
    num_visited = Enum.count(state.ids_of_visited)
    verdict(num_visited)
  end

  defp verdict_or_visit({state, prisoner, light_bulb, id}) do
    new_prisoners = Map.put(state.prisoners, id, prisoner)
    new_state = update(state, new_prisoners, light_bulb, id)
    visit(new_state)
  end

  defp update(state, prisoners, light_bulb, id) do
    state
    |> Map.put(:light_bulb, light_bulb)
    |> Map.put(:prisoners, prisoners)
    |> Map.update!(:current_visit, & &1 + 1)
    |> Map.update!(:ids_of_visited, & MapSet.put(&1, id))
  end

  defp verdict(num_visited) when num_visited == 100 do
    :set_free
  end

  defp verdict(_num_visited) do
    :shoot_them
  end
end
