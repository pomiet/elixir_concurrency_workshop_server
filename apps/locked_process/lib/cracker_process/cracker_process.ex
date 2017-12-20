defmodule CrackerProcess do
  use GenServer

  # ----------------------------------------- #
  # Client - API                              #
  # i.e. Client calls the following functions #
  # ----------------------------------------- #

  def pick_lock(server_pid) do
    GenServer.call(server_pid, {:pick, server_pid})
  end

  def start_link(_args \\ []) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  # ----------------------------------------- #
  # Server - API                              #
  # i.e. Server calls the following functions #
  # ----------------------------------------- #

  def init(_args) do
    {:ok, []}
  end

  def handle_call({:pick, _pid}, _from, _state) do
    message = 1..10
      |> Enum.map(fn(guess) ->
            send_guess(guess)
            |> examine_contents
          end )
      |> Enum.reject(fn(value) -> value == nil end)
      |> List.first

    if (nil == message) do
      {:reply, {:error, "Can't crack me!"}, []}
    else
      {:reply, {:ok, message}, []}
    end
  end

  def send_guess(guess) do
    LockedProcess.pick_lock("test", guess)
  end

  def examine_contents({:ok, message}) do
    # found it, so just return
    message
  end

  def examine_contents({:error, _message}) do
    # do nothing since i got nothing
  end
end
