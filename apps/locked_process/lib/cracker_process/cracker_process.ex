defmodule CrackerProcess do
  require Logger

  def pick_lock(pid) do
    message = 1..10
      |> Enum.map(fn(guess) ->
            LockedProcess.pick_lock(guess)
            |> examine_contents
          end )
      |> Enum.reject(fn(value) -> value == nil end)
      |> List.first

    if (nil == message) do
      [:error, "Can't crack me!"]
    else
      message
    end
  end

  def examine_contents({:ok, message}) do
    # found it, so just return
    [:ok, message]
  end

  def examine_contents({:error, message}) do
    # do nothing since i got nothing
  end
end
