defmodule OneHundredPrisoners.Prisoners.Counter do
  defstruct [:times_on_to_off]

  def new do
    %__MODULE__{times_on_to_off: 0}
  end

  def increment(%__MODULE__{} = counter) do
    Map.update!(counter, :times_on_to_off, & &1 + 1)
  end
end
