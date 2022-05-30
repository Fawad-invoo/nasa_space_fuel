defmodule NasaSpace.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      NasaSpaceWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: NasaSpace.PubSub},
      # Start the Endpoint (http/https)
      NasaSpaceWeb.Endpoint
      # Start a worker by calling: NasaSpace.Worker.start_link(arg)
      # {NasaSpace.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: NasaSpace.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    NasaSpaceWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
