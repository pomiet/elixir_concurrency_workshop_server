defmodule CrackerProcess do
  require Logger

  def pick_lock(pid) do
    message = 1..10
      |> Enum.map(fn(guess) ->
            LockedProcess.pick_lock(pid, guess) ++ [guess]
            |> examine_contents
          end )
      |> Enum.reject(fn(value) -> value == nil end)
      |> List.first

    message
  end

\  def examine_contents([:ok, message, combination]) do
    # found it, so just return
    [:ok, message, combination]
  end

  def examine_contents([:error, message, combination]) do
    # do nothing since i got nothing
  end
end
