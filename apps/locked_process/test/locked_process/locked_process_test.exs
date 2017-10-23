defmodule LockedProcessTest do
  use ExUnit.Case

  test "set combination with 1 returns ok" do
    {:ok, pid} = LockedProcess.set_combination(1, "message")
    assert [:ok, "message"] == LockedProcess.pick_lock(pid, 1)
  end

  test "attempt with 2 returns error" do
    {:ok, pid} = LockedProcess.set_combination(1, "message")
    assert [:error, "no access"] == LockedProcess.pick_lock(pid, 2)
  end

  test "attempt with 2 returns error and attempt with 1 returns ok" do
    {:ok, pid} = LockedProcess.set_combination(1, "message")
    assert [:error, "no access"] == LockedProcess.pick_lock(pid, 2)
    assert [:ok, "message"] == LockedProcess.pick_lock(pid, 1)
  end

end
