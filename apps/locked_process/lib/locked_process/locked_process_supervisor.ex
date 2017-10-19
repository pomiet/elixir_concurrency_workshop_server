defmodule LockedProcess.Supervisor do
  use Supervisor
  
  def start_link(opts) do
    Supervisor.start_link(__MODULE__, :ok, opts)
  end

  def init(:ok) do
    children = [
      LockedProcess.set_combination(1, "message")
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
