defmodule OneHundredPrisoners.VisitState do
  alias OneHundredPrisoners.Prisoners

  defstruct ~w[light_bulb prisoners current_visit]a

  def new do
    %__MODULE__{
      light_bulb: :off,
      prisoners: Prisoners.new(),
      current_visit: 1
    }
  end

  def update(%__MODULE__{} = state, light_blub, prisoners) do
    state
    |> Map.put(:light_bulb, light_blub)
    |> Map.put(:prisoners, prisoners)
    |> Map.update!(:current_visit, & &1 + 1)
  end
end
