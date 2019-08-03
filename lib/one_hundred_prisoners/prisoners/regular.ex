defmodule OneHundredPrisoners.Prisoners.Regular do
  defstruct [:found_light_on_once]

  def new do
    %__MODULE__{found_light_on_once: false}
  end
end
