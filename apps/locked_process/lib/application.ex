defmodule LockedProcess.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  # def start(_type, _args) do
  #   LockedProcess.Supervisor.start_link(name: LockedProcess.Supervisor)
  # end

  def main(args \\ []) do
    {options, _, _} =
      OptionParser.parse(args,
          switches: [combo: :string, message: :string,
                     port: :integer, delay: :integer])

    start(options[:combo], options[:message])
  end

  def start(combination, message) do
    LockSupervisor.start_link([combination, message])
    LockedProcessServer.control()
  end
end