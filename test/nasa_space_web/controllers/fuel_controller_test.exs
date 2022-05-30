defmodule NasaSpaceWeb.PageControllerTest do
  use NasaSpaceWeb.ConnCase

  test "GET /fuel_calculate", %{conn: conn} do
    conn =
      get(conn, "/fuel_calculate", %{
        "mass" => 2000,
        "flight_path" => [
          %{"launch" => 9.807},
          %{"land" => 1.62},
          %{"launch" => 1.62},
          %{"launch" => 9.807}
        ]
      })

    assert json_response(conn, 200) = %{"fuel_estimate" => _value}
  end
end
