defmodule LockedProcess.SupervisorTest do
  use ExUnit.Case, async: true

  setup do
    {:ok, server_pid} = LockSupervisor.start_link([123, "rock on", 1])
    {:ok, server: server_pid}
  end

  test "supervisor restarts after exit", %{server: pid} do
    assert {:ok, "rock on"} == LockedProcess.pick_lock(123)
    LockedProcess.stop()
    :timer.sleep 1000
    assert {:ok, "rock on"} == LockedProcess.pick_lock(123)
  end
end
