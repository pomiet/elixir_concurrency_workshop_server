defmodule LockSupervisor do
  use Supervisor

  def start_link([combination, message, delay]) do
    children = [
      worker(LockedProcess, [combination, message, delay])
    ]
    opts = [strategy: :one_for_one, name: LockedProcess.Supervisor]

    {:ok, _pid} = Supervisor.start_link(children, opts)
  end

  def init(:ok) do
    # children = [
    #   worker(LockedProcess, [123])
    # ]
    # opts = [strategy: :one_for_one, name: LockedProcess.Supervisor]
    #
    # Supervisor.init(children, opts)
  end
end
