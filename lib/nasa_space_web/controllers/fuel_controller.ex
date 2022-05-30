defmodule NasaSpaceWeb.FuelController do
  use NasaSpaceWeb, :controller

  alias NasaSpace.Fuel.FuelCalulation
  alias NasaSpaceWeb.ErrorView

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def calculate_fuel_for_trip(conn, _params) do
    flight_path = [{{:launch, 9.807}}, {{:land, 1.62}}, {{:launch, 1.62}}, {{:land, 9.807}}]
    mass = 28801
    case FuelCalulation.calculate_fuel(mass, flight_path) do
      {:ok, fuel_estimate} -> render(conn, "show.json", fuel_estimate: fuel_estimate)
      {:error, message} -> error(conn, message)
    end
  end

  def calculate_fuel_for_trip(conn, _params) do
    error(conn)
  end

  defp error(conn, message \\ "Invalid Params") do
    conn
    |> render(ErrorView, "400.json", error: message)
  end
end
