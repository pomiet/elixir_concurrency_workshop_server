defmodule LockedProcessTest do
  use ExUnit.Case

  setup do
    {:ok, server_pid} = LockedProcess.start_link([123, "Correct: E"])
    {:ok, server: server_pid}
  end

  test "try default combination returns ok", %{server: pid} do
    assert {:ok, "Correct: E"} == LockedProcess.pick_lock(pid, 123)
  end

  test "attempt with 2 returns error", %{server: pid} do
    assert {:error, "no access"} == LockedProcess.pick_lock(pid, 2)
  end

  test "attempt with 2 returns error and attempt with 123 returns ok", %{server: pid} do
    assert {:error, "no access"} == LockedProcess.pick_lock(pid, 2)
    assert {:ok, "Correct: E"} == LockedProcess.pick_lock(pid, 123)
  end

  test "reset combination success" ,%{server: pid} do
    assert {:ok} == LockedProcess.reset(pid, {123, [456, "Correct: L"]})
    assert {:ok, "Correct: L"} == LockedProcess.pick_lock(pid, 456)
  end

  test "reset combination failure" ,%{server: pid} do
    assert {:error,"no access"} == LockedProcess.reset(pid, {456, [789, "Correct: L"]})
  end
end
