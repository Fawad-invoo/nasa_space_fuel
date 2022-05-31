defmodule NasaSpace.FlightRouteRecursion do
  alias NasaSpace.Fuel.FuelCalulation

  # directive_fuel is mass
  def each([head | tail], mass, directive_fuel) do
    IO.inspect(mass, label: "mass")
    directive_fuel_additional = FuelCalulation.directive(head, mass)

    tail =
      case directive_fuel_additional do
        {:error, _} -> []
        {:ok, _fuel} -> tail
      end

    updated_fuel = add_fuel(directive_fuel, directive_fuel_additional)
    IO.inspect(updated_fuel, label: "updated_fuel")
    IO.inspect("###########")
    each(tail, elem(updated_fuel, 1), updated_fuel)
  end

  def each([], _mass, directive_fuel) do
    directive_fuel
  end

  @doc """
    Add current fuel and previous fuel
  """
  def add_fuel({:ok, prev_fuel}, {:ok, curr_fuel}) do
    IO.inspect(prev_fuel, label: "prev")
    IO.inspect(curr_fuel, label: "curr")
    curr_fuel = prev_fuel + curr_fuel
    {:ok, curr_fuel}
  end

  def add_fuel(_prev_fuel, _current_fuel), do: {:error, :invalid_key}
end
