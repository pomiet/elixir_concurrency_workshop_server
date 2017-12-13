defmodule LockedProcess do
  use GenServer

  # ----------------------------------------- #
  # Client - API                              #
  # i.e. Client calls the following functions #
  # ----------------------------------------- #
  def pick_lock(combination) do
    GenServer.call(__MODULE__, {:pick, combination})
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

  def start_link([combination, message]) do
    GenServer.start_link(__MODULE__, [combination, message], name: __MODULE__)
  end

  def start_link(combination, message) do
    GenServer.start_link(__MODULE__, [combination, message], name: __MODULE__)
  end

  # ----------------------------------------- #
  # Server - API                              #
  # i.e. Server calls the following functions #
  # ----------------------------------------- #

  def init([combination, message]) do
    {:ok, [combination, message]} # state is stored as list of combinations
  end

  def handle_call({:pick, combination_attempt}, _from, [combination, message]) do
    if (combination_attempt == combination) do
      {:reply, {:ok, message}, [combination, message]}
    else
      {:reply, {:error,"no access"}, [combination, message]}
    end
  end

  def handle_call({:reset, {old_combination, [new_combination, new_message]}}, _from, [combination, message]) do
    if (old_combination == combination) do
      {:reply, {:ok}, [new_combination, new_message]}
    else
      {:reply, {:error,"no access"}, [combination, message]}
    end
  end
end
