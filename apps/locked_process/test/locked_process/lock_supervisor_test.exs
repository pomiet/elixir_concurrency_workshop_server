defmodule LockedProcess.SupervisorTest do
  use ExUnit.Case

  setup do
    {:ok, server_pid} = LockSupervisor.start_link([123, "Correct: E", 1])
    {:ok, server: server_pid}
  end

  test "try default combination returns ok" do
    assert {:ok, "Correct: E"} == LockedProcess.pick_lock(123)
  end

  test "attempt with 2 returns error" do
    assert {:error, "Can't crack me!"} == LockedProcess.pick_lock(2)
  end

  test "reset combination success" do
    assert {:ok} == LockedProcess.reset({123, [456, "Correct: L"]})
    assert {:ok, "Correct: L"} == LockedProcess.pick_lock(456)
  end

  test "reset combination failure" do
    assert {:error,"Can't crack me!"} == LockedProcess.reset({456, [789, "Correct: L"]})
  end

end
