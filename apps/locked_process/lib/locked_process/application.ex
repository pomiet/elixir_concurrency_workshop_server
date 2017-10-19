defmodule LockedProcess.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  # def start(_type, _args) do
  #   LockedProcess.Supervisor.start_link(name: LockedProcess.Supervisor)
  # end


  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # LockedProcess.set_combination(1, "message"), []
      # Starts a worker by calling: LockedProcess.Worker.start_link(arg)
      # {LockedProcess.Worker, arg},
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: LockedProcess.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
