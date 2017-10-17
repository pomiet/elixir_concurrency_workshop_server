defmodule LockedProcess do
  use GenServer
  require Logger

  @moduledoc """
  A lockes process contains a single digit combination that when opened
  returns a message.
  """
  def handle_call(:pick, _from, value) do
    {:reply, value, value}
  end

  def pick_lock(pid, attempt) do
    [combination, message] = GenServer.call(pid, :pick)
    if (attempt == combination) do
      [:ok, message]
    else
      [:error, "try again"]
    end
  end

  def set_combination(combination, message) do
    GenServer.start_link(__MODULE__, [combination, message])
  end
end
