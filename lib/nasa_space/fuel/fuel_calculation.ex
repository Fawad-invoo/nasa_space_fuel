defmodule NasaSpace.Fuel.FuelCalulation do
  @moduledoc """
  This module calculate fuel according to these parameters
  - Planets-gravity
  - Mass
  - Launch or Land
  directive input format [{:launch,9.807},{:land, 1.62}, {:launch, 1.62}, {:land, 9.807}]
  """

  alias NasaSpace.FlightRouteRecursion

  def calculate_fuel(%{"mass" => mass, "flight_path" => flight_route}) do
    FlightRouteRecursion.each(flight_route, mass)
  end

  @doc """
      ## Launch Formula
      - mass * gravity * 0.042 - 33
      ## Land Formula
      - mass * gravity * 0.033 - 42
  """

  def directive({:launch, gravity}, mass) do
    fuel_estimate = trunc(mass * gravity * 0.042 - 33)
    additional_fuel = directive_additional_fuel(fuel_estimate, gravity, :launch)
    launch_fuel_estimate = additional_fuel + fuel_estimate
    {:ok, launch_fuel_estimate}
  end

  def directive({:land, gravity}, mass) do
    fuel_estimate = trunc(mass * gravity * 0.033 - 42)
    additional_fuel = directive_additional_fuel(fuel_estimate, gravity, :land)
    land_fuel_estimate = additional_fuel + fuel_estimate
    {:ok, land_fuel_estimate}
  end

  def directive(_path, _mass) do
    {:error, :invalid_directive}
  end

  defp directive_additional_fuel(mass, gravity, directive, additonal_fuel \\ 0) when mass > 0 do
    fuel_estimate =
      case directive do
        :launch -> trunc(mass * gravity * 0.042 - 33)
        :land -> trunc(mass * gravity * 0.033 - 42)
      end

    additonal_fuel =
      if fuel_estimate > 0 do
        fuel_estimate + additonal_fuel
      else
        additonal_fuel
      end

    directive_additional_fuel(fuel_estimate, gravity, directive, additonal_fuel)
  end

  defp directive_additional_fuel(mass, gravity, directive, additonal_fuel) do
    additonal_fuel
  end
end
