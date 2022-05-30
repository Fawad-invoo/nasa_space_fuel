defmodule NasaSpace.Fuel.FuelCalulation do
  @moduledoc """
  This module calculate fuel according to these parameters
  - Planets-gravity
  - Mass
  - Launch or Land
  directive input format [{:launch,9.807},{:land, 1.62}, {:launch, 1.62}, {:land, 9.807}]
  """

  alias NasaSpace.FlightRouteRecursion

  def calculate_fuel(mass, flight_route) do
    FlightRouteRecursion.each(flight_route, mass)
  end

  @doc """
      ## Launch Formula
      - mass * gravity * 0.042 - 33
      ## Land Formula
      - mass * gravity * 0.033 - 42
  """
  def directive({:launch, gravity}, mass) do
    fuel_estimate = mass * gravity * 0.042 - 33
    additional_fuel = directive_additional_fuel(fuel_estimate, gravity, :launch)
    launch_fuel_estimate = additional_fuel + fuel_estimate
    {:ok, launch_fuel_estimate}
  end

  def directive({:land, gravity}, mass) do
    fuel_estimate = mass * gravity * 0.033 - 42
    additional_fuel = directive_additional_fuel(fuel_estimate, gravity, :land)
    land_fuel_estimate = additional_fuel + fuel_estimate
    {:ok, land_fuel_estimate}
  end

  def directive({:_, _gravity}, _mass) do
    {:error, :invalid_directive}
  end

  defp directive_additional_fuel(mass, gravity, directive, additonal_fuel \\ 0) when mass > 0 do
    fuel_estimate =
      case directive do
        :launch -> mass * gravity * 0.042 - 33
        :land -> mass * gravity * 0.033 - 42
      end

    IO.inspect(gravity, label: "gravity")
    IO.inspect(mass, label: "mass")
    IO.inspect(fuel_estimate, label: "launch_land")
    additonal_fuel = fuel_estimate + additonal_fuel
    directive_additional_fuel(fuel_estimate, gravity, directive, additonal_fuel)
  end

  defp directive_additional_fuel(mass, gravity, directive, additonal_fuel) do
    additonal_fuel
  end

  defp validate_fuel_calclation_params(%{"mass" => mass, "flight_path" => flight_path} = params),
    do: {:ok, params}

  defp validate_fuel_calclation_params(_params) do
    {:errror, :invalid_params}
  end
end
