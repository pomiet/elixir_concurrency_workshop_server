defmodule CrackerProcessTest do
  use ExUnit.Case

  test "crack the lock of a combination of 1 to get message" do
    {:ok, pid} = LockedProcess.start_link([1, "message"])
    assert [:ok, "message"] == CrackerProcess.pick_lock(pid)
  end

  test "crack the lock of a combination of 9 to get message" do
    {:ok, pid} = LockedProcess.start_link([9, "message"])
    assert [:ok, "message"] == CrackerProcess.pick_lock(pid)
  end

  test "try to crack the lock of a combination outside of cracker range" do
    {:ok, pid} = LockedProcess.start_link([1500, "message"])
    assert [:error, "Can't crack me!"] == CrackerProcess.pick_lock(pid)
  end

end
