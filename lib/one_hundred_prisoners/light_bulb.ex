defmodule OneHundredPrisoners.LightBulb do
  alias OneHundredPrisoners.Prisoners.{Counter, Regular}

  def maybe_toggle(:off, %Counter{} = prisoner) do
    new_prisoner = Counter.increment(prisoner)
    {:on, new_prisoner}
  end

  def maybe_toggle(:on, %Regular{found_light_on_once: false}) do
    {:off, %Regular{found_light_on_once: true}}
  end

  def maybe_toggle(light_bulb, prisoner) do
    {light_bulb, prisoner}
  end
end
