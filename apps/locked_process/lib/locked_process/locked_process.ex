defmodule LockedProcess do
  use GenServer

  # ----------------------------------------- #
  # Client - API                              #
  # i.e. Client calls the following functions #
  # ----------------------------------------- #
  def pick_lock(server_name, combination) do
    # what should i do now?
  end

  def reset(server_name, {old_combination, [new_combination, new_message]}) do
    # what should i do now?
  end

  def start_link([combination, message, delay, server_name]) do
    # what should i do now?
  end

  def start_link(combination, message, delay, server_name) do
    # what should i do now?
  end

  def stop(server_name) do
    # what should i do now?
  end

  # ----------------------------------------- #
  # Server - API                              #
  # i.e. Server calls the following functions #
  # ----------------------------------------- #

  def init([combination, message, delay]) do
    # what should i do now?
  end

  def handle_call({:pick, combination_attempt}, _from, [combination, message, delay]) do
    # what should i do now?
  end

  def handle_call({:reset, {old_combination, [new_combination, new_message]}}, _from, [combination, message, delay]) do
    # what should i do now?
  end

  defp ref(server_name) do
    # what should i do now?
  end

  defp try_call(server_id, message) do
    # what should i do now?
  end
end
