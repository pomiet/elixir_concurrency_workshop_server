defmodule CrackerProcess do
  require Logger

  def pick_lock(pid) do
    LockedProcess.pick_lock(pid, 1)
  end

end
