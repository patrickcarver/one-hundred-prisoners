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

  def run do
    turn(light_bulb: :off, prisoners: create_prisoners())
  end

  def turn(light_bulb: state, prisoners: prisoners) do
    {index, prisoner} = Enum.random(prisoners)

    {new_state, new_prisoner} = process(state, prisoner)

    case new_prisoner do
      %{type: :counter, times_on_to_off: 100} ->
        IO.puts "Finished"
        prisoners
      _ ->
        new_prisoners = Map.put(prisoners, index, new_prisoner)
        turn(light_bulb: new_state, prisoners: new_prisoners)
    end
  end

  def process(:off, %{type: :counter, times_on_to_off: count}) do
    new_prisoner = %{type: :counter, times_on_to_off: count + 1}
    {:on, new_prisoner}
  end

  def process(:on, %{type: :counter} = prisoner) do
    {:on, prisoner}
  end

  def process(:on, %{type: :regular, have_found_light_on_once: false}) do
    {:off, %{type: :regular, have_found_light_on_once: true}}
  end

  def process(state, prisoner) do
    {state, prisoner}
  end

  def create_prisoners() do
    1..99
    |> Enum.reduce(%{}, fn index, acc -> Map.put(acc, index, %{type: :regular, have_found_light_on_once: false}) end)
    |> Map.put(100, %{type: :counter, times_on_to_off: 0})
  end
end
