defmodule CrackerProcessTest do
  use ExUnit.Case

  setup do
    {:ok, server_pid} = CrackerProcess.start_link()
    {:ok, server: server_pid}
  end

  test "crack the lock of a combination of 1 to get message", %{server: pid} do
    LockedProcess.start_link([1, "message", 1])
    assert {:ok, "message"} == CrackerProcess.pick_lock(pid)
  end

  test "crack the lock of a combination of 9 to get message", %{server: pid} do
    LockedProcess.start_link([9, "message", 1])
    assert {:ok, "message"} == CrackerProcess.pick_lock(pid)
  end

  test "try to crack the lock of a combination outside of cracker range", %{server: pid} do
    LockedProcess.start_link([1500, "message", 1])
    assert {:error, "Can't crack me!"} == CrackerProcess.pick_lock(pid)
  end
end
