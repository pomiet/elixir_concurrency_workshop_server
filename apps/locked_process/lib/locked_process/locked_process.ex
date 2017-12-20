defmodule LockedProcess do
  use GenServer

  # ----------------------------------------- #
  # Client - API                              #
  # i.e. Client calls the following functions #
  # ----------------------------------------- #
  def pick_lock(server_id, combination) do
    # try_call(server_id, {:pick, combination})
    GenServer.call({:global, {:combolock, "test"}}, {:pick, combination})
  end

  def pick_lock(server_pid, combination) do
     GenServer.call(server_pid, {:pick, combination})
  end

  def reset({old_combination, [new_combination, new_message]}) do
    GenServer.call(__MODULE__, {:reset, {old_combination, [new_combination, new_message]}})
  end

  def reset(server_pid, {old_combination, [new_combination, new_message]}) do
    GenServer.call(server_pid, {:reset, {old_combination, [new_combination, new_message]}})
  end

  def start_link([combination, message, delay, server_name]) do
    GenServer.start_link(__MODULE__, [combination, message, delay], name: ref(server_name))
  end

  def start_link(combination, message, delay, server_name) do
    GenServer.start_link(__MODULE__, [combination, message, delay], name: ref(server_name))
  end

  def stop() do
    GenServer.stop({:global, {:combolock, "test"}})
  end

  # ----------------------------------------- #
  # Server - API                              #
  # i.e. Server calls the following functions #
  # ----------------------------------------- #

  def init([combination, message, delay]) do
    {:ok, [combination, message, delay]}
  end

  def handle_call({:pick, combination_attempt}, _from, [combination, message, delay]) do
    # Simluate resource utliization
    # :timer.sleep(delay)

    if (combination_attempt == combination) do
      {:reply, {:ok, message}, [combination, message, delay]}
    else
      {:reply, {:error,"Can't crack me!"}, [combination, message, delay]}
    end
  end

  def handle_call({:reset, {old_combination, [new_combination, new_message]}}, _from, [combination, message, delay]) do
    if (old_combination == combination) do
      {:reply, {:ok}, [new_combination, new_message, delay]}
    else
      {:reply, {:error,"Can't crack me!"}, [combination, message, delay]}
    end
  end

  defp ref(server_id) do
    {:global, {:combolock, server_id}}
  end

  defp try_call(server_id, message) do
    case GenServer.whereis(ref(server_id)) do
      nil ->
        {:error, :invalid_server}
      combolock ->
        GenServer.call(combolock, message)
    end
  end
end
