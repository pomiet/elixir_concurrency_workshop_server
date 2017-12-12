defmodule LockedProcess.SupervisorTest do
  use ExUnit.Case

  setup do
    {:ok, server_pid} = LockSupervisor.start_link([123])
    {:ok, server: server_pid}
  end

  test "try default combination returns ok" do
    assert {:ok} == LockedProcess.pick_lock(123)
  end

  test "attempt with 2 returns error" do
    assert {:error, "no access"} == LockedProcess.pick_lock(2)
  end

  test "reset combination success" do
    assert {:ok} == LockedProcess.reset({123, 456})
  end

  test "reset combination failure" do
    assert {:error,"no access"} == LockedProcess.reset({456, 789})
  end

end
