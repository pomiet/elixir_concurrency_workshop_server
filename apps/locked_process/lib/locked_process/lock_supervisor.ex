defmodule LockSupervisor do
  use Supervisor

  def start_link([combination, message, delay]) do
    {:ok, pid} = Supervisor.start_link(__MODULE__, [combination, message, delay])
  end

  def init([combination, message, delay]) do
    children = [
      worker(LockedProcess, [combination, message, delay])
    ]
    opts = [strategy: :one_for_one, name: LockedProcess.Supervisor]

    supervise(children, opts)
  end
end
