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
    {index, prisoner} = Enum.random(state.prisoners)

    {new_light_bulb, new_prisoner} = Prisoner.visit_room(state.light_bulb, prisoner)

    case new_prisoner do
      %Counter{times_on_to_off: 100} ->
        verdict(state)
      _ ->
        new_prisoners = Map.put(state.prisoners, index, new_prisoner)
        new_state = update(state, new_light_bulb, new_prisoners, index)
        visit(new_state)
    end
  end


  defp update(state, light_blub, prisoners, index) do
    state
    |> Map.put(:light_bulb, light_blub)
    |> Map.put(:prisoners, prisoners)
    |> Map.update!(:current_visit, & &1 + 1)
    |> Map.update!(:ids_of_visited, & MapSet.put(&1, index))
  end

  defp verdict(state) do
    num_visited = Enum.count(state.ids_of_visited)
    if num_visited == 100 do
      :set_free
    else
      :shoot_them
    end
  end
end
