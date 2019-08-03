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

  defmodule Counter do
    defstruct [:times_on_to_off]

    def new do
      %__MODULE__{times_on_to_off: 0}
    end

    def increment(%__MODULE__{} = counter) do
      Map.update!(counter, :times_on_to_off, & &1 + 1)
    end
  end

  defmodule Regular do
    defstruct [:found_light_on_once]

    def new do
      %__MODULE__{found_light_on_once: false}
    end
  end

  def run do
    visit(light_bulb: :off, prisoners: create_prisoners(), visits: 1)
  end

  def visit(light_bulb: light_bulb_state, prisoners: prisoners, visits: visits) do
    {index, prisoner} = Enum.random(prisoners)

    {new_light_bulb_state, new_prisoner} = process(light_bulb_state, prisoner)

    case new_prisoner do
      %Counter{times_on_to_off: 100} ->
        visits
      _ ->
        new_prisoners = Map.put(prisoners, index, new_prisoner)
        visit(light_bulb: new_light_bulb_state, prisoners: new_prisoners, visits: visits + 1)
    end
  end

  def process(:off, %Counter{} = prisoner) do
    new_prisoner = Counter.increment(prisoner)
    {:on, new_prisoner}
  end

  def process(:on, %Regular{found_light_on_once: false}) do
    {:off, %Regular{found_light_on_once: true}}
  end

  def process(light_bulb_state, prisoner) do
    {light_bulb_state, prisoner}
  end

  def create_prisoners() do
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
