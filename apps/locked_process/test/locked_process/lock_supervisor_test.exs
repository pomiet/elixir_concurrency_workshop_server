defmodule LockedProcess.SupervisorTest do
  use ExUnit.Case, async: true

  setup do
    {:ok, server_pid} = LockSupervisor.start_link([123, "Correct: E", 1])
    {:ok, server: server_pid}
  end

  test "supervisor restarts after exit", %{server: pid} do
    assert {:ok, "Correct: E"} == LockedProcess.pick_lock(123)
    Process.unlink(pid)
    Process.exit(pid, :shutdown)
    :timer.sleep 1000
    assert {:ok, "Correct: E"} == LockedProcess.pick_lock(123)
  end
end
