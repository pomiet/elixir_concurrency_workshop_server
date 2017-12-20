defmodule LockedProcessTest do
  use ExUnit.Case

  setup do
    server_name = "test"
    {:ok, server_pid} = LockedProcess.start_link([123, "Correct: E", 1, server_name])
    {:ok, server: server_name}
  end

  test "try default combination returns ok", %{server: sname} do
    assert {:ok, "Correct: E"} == LockedProcess.pick_lock(sname, 123)
  end

  test "attempt with 2 returns error", %{server: sname} do
    assert {:error, "Can't crack me!"} == LockedProcess.pick_lock(sname, 2)
  end

  test "attempt with 2 returns error and attempt with 123 returns ok", %{server: sname} do
    assert {:error, "Can't crack me!"} == LockedProcess.pick_lock(sname, 2)
    assert {:ok, "Correct: E"} == LockedProcess.pick_lock(sname, 123)
  end

  test "reset combination success" ,%{server: sname} do
    assert {:ok} == LockedProcess.reset(sname, {123, [456, "Correct: L"]})
    assert {:ok, "Correct: L"} == LockedProcess.pick_lock(sname, 456)
  end

  test "reset combination failure" ,%{server: sname} do
    assert {:error,"Can't crack me!"} == LockedProcess.reset(sname, {456, [789, "Correct: L"]})
  end
end
