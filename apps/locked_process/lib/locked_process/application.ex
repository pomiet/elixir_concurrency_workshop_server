defmodule LockedProcess.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  # def start(_type, _args) do
  #   LockedProcess.Supervisor.start_link(name: LockedProcess.Supervisor)
  # end

  def main(args \\ []) do
    start(:null, "")
  end

  def start(_type, _args) do
    LockSupervisor.start_link([123])
  end
end
