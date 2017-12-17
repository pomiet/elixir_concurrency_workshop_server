defmodule LockedProcess.Application do
  use Application

  def main(args \\ []) do
    {options, _, _} = parse_args(args)

    start(options[:combo], options[:message],
          options[:port], options[:delay])
  end

  def start(combination, message, port, delay) do
    LockSupervisor.start_link([combination, message, delay])
    # PortSingleton.start_link()
    # PortSingleton.update(port)
    LockedProcessServer.control(port)
  end

  def start(_type, args) do
    {options, _, _} = parse_args(args)

    start(options[:combo], options[:message],
          options[:port], options[:delay])
  end

  def parse_args(args \\ []) do
    OptionParser.parse(args,
        switches: [combo: :string, message: :string,
                   port: :integer, delay: :integer])
  end
end
