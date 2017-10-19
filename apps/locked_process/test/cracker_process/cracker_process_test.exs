defmodule CrackerProcessTest do
  use ExUnit.Case

  test "crack the lock of a combination of 1 to get message" do
    {:ok, pid} = LockedProcess.set_combination(1, "message")
    assert [:ok, "message"] == CrackerProcess.pick_lock(pid)
  end

  test "combination of 2 does not get message" do
    {:ok, pid} = LockedProcess.set_combination(1, "message")
    assert [:ok, "message"] == CrackerProcess.pick_lock(pid)
  end

end
