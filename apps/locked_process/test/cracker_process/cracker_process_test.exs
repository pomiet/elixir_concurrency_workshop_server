defmodule CrackerProcessTest do
  use ExUnit.Case

  test "crack the lock of a combination of 1 to get message" do
    {:ok, pid} = LockedProcess.set_combination(1, "message")
    assert [:ok, "message", 1] == CrackerProcess.pick_lock(pid)
  end

  test "crack the lock of a combination of 2 to get message" do
    {:ok, pid} = LockedProcess.set_combination(2, "message")
    assert [:ok, "message", 2] == CrackerProcess.pick_lock(pid)
  end

end
