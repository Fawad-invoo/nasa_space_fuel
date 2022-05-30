defmodule NasaSpace.FlightRouteRecursion do
  alias NasaSpace.Fuel.FuelCalulation

  def each([head | tail], mass, directive_fuel \\ {:ok, 0}) do
    IO.inspect(mass, label: "mass")
    directive_fuel_additional = FuelCalulation.directive(head, mass)
    IO.inspect(directive_fuel_additional, label: "fuel_estimate")

    tail =
      case directive_fuel_additional do
        {:error, _} -> []
        {:ok, _fuel} -> tail
      end

    updated_fuel = add_fuel(directive_fuel, directive_fuel_additional)
    each(tail, mass, updated_fuel)
  end

  def each([], _mass, directive_fuel) do
    directive_fuel
  end

  @doc """
    Add current fuel and previous fuel
  """
  def add_fuel({:ok, prev_fuel}, {:ok, curr_fuel}) do
    IO.inspect(curr_fuel, label: "current")
    curr_fuel = prev_fuel + curr_fuel
    {:ok, curr_fuel}
  end

  def add_fuel(_directive_fuel), do: {:error, 0}
end
