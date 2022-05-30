defmodule NasaSpaceWeb.Plugs.Parser do
  import Plug.Conn

  def init(params), do: params

  def call(conn, _params) do
    with(
      {:ok, body, _conn} <- Plug.Conn.read_body(conn),
      body_params <- JSON.decode!(body)
    ) do
      conn
      |> Plug.Conn.assign(:params_body, body_params)
    else
      error = {:error, _error_type, _err} ->
        conn
        |> send_resp(400, error)
        |> halt
    end
  end

  defp format_flight_path(%{"flight_path" => flight_path} = _body_params) do
    Enum.map(flight_path, fn path ->
      convert_to_klist(path)
    end)
  end

  def convert_to_klist(map) do
    Enum.map(map, fn {key, value} -> {String.to_existing_atom(key), value} end) |> List.to_tuple()
  end
end
