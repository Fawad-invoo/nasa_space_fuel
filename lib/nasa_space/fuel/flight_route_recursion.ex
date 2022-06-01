defmodule NasaSpace.FlightRouteRecursion do
  alias NasaSpace.Fuel.FuelCalulation

  def each([head | tail], mass) do
    with(
      {:ok, directive_fuel_additional} <- FuelCalulation.directive(head, mass),
      {:ok, updated_fuel} = add_fuel(mass, directive_fuel_additional)
    ) do
      each(tail, updated_fuel)
    else
      err ->
        {:error, err}
    end
  end

  def each([], updated_fuel) do
    {:ok, updated_fuel}
  end

  @doc """
    Add current fuel and previous fuel_mass
  """
  def add_fuel(prev_fuel_mass, curr_fuel) do
    curr_fuel = prev_fuel_mass + curr_fuel
    {:ok, curr_fuel}
  end
end
