defmodule NasaSpaceWeb.FuelView do
  use NasaSpaceWeb, :view

  def render("show.json", %{fuel_estimate: fuel_estimate}) do
    %{fuel_estimate: fuel_estimate}
  end
end
