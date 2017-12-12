defmodule LockedProcess do
  use GenServer
  require Logger

  use GenServer

  # ----------------------------------------- #
  # Client - API                              #
  # i.e. Client calls the following functions #
  # ----------------------------------------- #
  def pick_lock(combination) do
    GenServer.call(__MODULE__, {:pick, combination})
  end

  def reset({old_combination, new_combination}) do
    GenServer.call(__MODULE__, {:reset, {old_combination, new_combination}})
  end

  def pick_lock(server_pid, combination) do
    GenServer.call(server_pid, {:pick, combination})
  end

  def reset(server_pid, {old_combination, new_combination}) do
    GenServer.call(server_pid, {:reset, {old_combination, new_combination}})
  end

  def start_link(combination) do
    GenServer.start_link(__MODULE__, combination, name: __MODULE__)
  end


  # ----------------------------------------- #
  # Server - API                              #
  # i.e. Server calls the following functions #
  # ----------------------------------------- #

  def init(combination) do
    {:ok, [combination]} # state is stored as list of combinations
  end

  def handle_call({:pick, combination_attempt}, _from, combination) do # ----> aynchronous request
    if combination_attempt in combination do
      {:reply, {:ok}, combination}
    else
      {:reply, {:error,"no access"}, combination}
    end
  end

  def handle_call({:reset, {old_combination, new_combination}}, _from, combination) do
    if old_combination in combination do
      {:reply, {:ok}, [new_combination]}
    else
      {:reply, {:error,"no access"}, combination}
    end
  end
end
