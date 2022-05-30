defmodule NasaSpaceWeb.PageController do
  use NasaSpaceWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
