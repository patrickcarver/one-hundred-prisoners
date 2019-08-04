defmodule OneHundredPrisoners do
  # TURNS
  # light_bulb_state (:on, :off; starts with :off)
  # list_of_prisoners (1 Counter, 99 Regulars)

  # PRISONER TYPES
  #
  # Counter
  # always turn the light on if it is off
  # the 100th time this is done, sure that all prisoners
  # have visited the room
  #
  # Regular
  # turn the light off the first time they find it on;
  # otherwise leave it in the state it is found

  alias __MODULE__.{LightBulb, VisitState}
  alias __MODULE__.Prisoners.{Counter}

  def run do
    VisitState.new()
    |> visit()
  end

  def visit(state) do
    {index, prisoner} = Enum.random(state.prisoners)

    {new_light_bulb, new_prisoner} = LightBulb.maybe_toggle(state.light_bulb, prisoner)

    case new_prisoner do
      %Counter{times_on_to_off: 100} ->
        state.current_visit
      _ ->
        new_prisoners = Map.put(state.prisoners, index, new_prisoner)
        VisitState.update(state, new_light_bulb, new_prisoners)
        |> visit()
    end
  end


end
