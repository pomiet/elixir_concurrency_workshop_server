defmodule CrackerProcess do
  use GenServer

  # ----------------------------------------- #
  # Client - API                              #
  # i.e. Client calls the following functions #
  # ----------------------------------------- #

  def pick_lock(server_pid) do
    # what should i do now?
  end

  def start_link(_args \\ []) do
    # what should i do now?
  end

  # ----------------------------------------- #
  # Server - API                              #
  # i.e. Server calls the following functions #
  # ----------------------------------------- #

  def init(_args) do
    # what should i do now?
  end

  def handle_call({:pick, _pid}, _from, _state) do
    # what should i do now?
  end

  def send_guess(guess) do
    # what should i do now?
  end

  def examine_contents({:ok, message}) do
    # what should i do now?
  end

  def examine_contents({:error, _message}) do
    # what should i do now?
  end
end
