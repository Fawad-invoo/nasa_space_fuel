defmodule NasaSpaceWeb.Plugs.Parser do
  @moduledoc """
      This Plug validate params keys & update input format
      
      ** Input Format [%{"launch" => 9.807},{"land" => 1.62},{"launch" => 1.62},{"land" => 9.807}]

      ** Ouput Format [{:launch , 9.807},{:land , 1.62},{:launch , 1.62},{land , 9.807}]
  """
  import Plug.Conn

  def init(params), do: params

  def call(conn, _params) do
    with(
      {:ok, body, _conn} <- Plug.Conn.read_body(conn),
      body_params <- JSON.decode!(body),
      {:ok, flight_path} <- format_flight_path(body_params)
    ) do
      body_params = Map.put(body_params, "flight_path", flight_path)

      conn
      |> Plug.Conn.assign(:params_body, body_params)
    else
      _err ->
        conn
        |> Plug.Conn.resp(400, "Invalid params")
        |> Plug.Conn.send_resp()
        |> halt
    end
  end

  @doc """
   validate params keys & reverse path
  """
  defp format_flight_path(%{"flight_path" => flight_path, "mass" => _mass} = _body_params) do
    flight_path
    |> Enum.reduce_while([], fn item, acc ->
      case path_atom(item) do
        error = {:error, message} -> {:halt, {:error, error}}
        path -> {:cont, [path | acc]}
      end
    end)
    |> reduce_while_check()
  end

  defp format_flight_path(_body_params) do
    {:error, :missing_params}
  end

  defp path_atom(%{"launch" => gravity}) do
    {:launch, gravity}
  end

  defp path_atom(%{"land" => gravity}) do
    {:land, gravity}
  end

  defp path_atom(_path) do
    {:error, :invalid_directive}
  end

  defp reduce_while_check({:error, message} = error) do
    error
  end

  defp reduce_while_check(result) do
    {:ok, result}
  end
end
