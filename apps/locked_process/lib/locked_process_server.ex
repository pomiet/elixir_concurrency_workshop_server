# Module for the main erlang process that controls all linked child erlang processes
defmodule LockedProcessServer do
  def control(port) do
    control_pid = self()
    spawn_monitor(LockedProcessListener, :start, [control_pid, port])
    wait_for_command()
  end

  def wait_for_command() do
    receive do
      message      -> IO.puts "Unexpected Exit: #{inspect message}"
    end
  end
end

# Module to isolate the first child process responsible for accepting connections.
defmodule LockedProcessListener do
  # Convension all erlang processes have "start" function.
  def start(control_pid, port) do
    listener(control_pid, port)
  end

  def listener(control_pid, port) do
    IO.puts "Locked Process Listening"
    # port = PortSingleton.value()
    listening(control_pid,
              :gen_tcp.listen(port, [:binary, packet: :line, active: false, reuseaddr: true]))
  end

  def listening(control_pid, {:ok, listen_socket}) do
    accept_loop(control_pid, listen_socket)
  end

  def listening(_, {:error, message}) do
    IO.puts "LISTEN ERROR #{message}"
  end

  # Convension to suffix _loop for control loops
  def accept_loop(control_pid, listen_socket) do
    accepted(control_pid, :gen_tcp.accept(listen_socket))
    accept_loop(control_pid, listen_socket)
  end

  def accepted(control_pid, {:ok, client_socket}) do
    spawn_monitor(LockedProcessConnection, :start, [control_pid, client_socket])
  end

  def accepted(_, {:error, message}) do
    IO.puts "ACCEPT ERROR #{message}"
  end
end

# Module to isolate read/write of each connection
defmodule LockedProcessConnection do
  # Convension all erlang processes have "start" function.
  def start(control_pid, client_socket) do
    received_loop(control_pid, client_socket)
  end

  # Convension to suffix _loop for control loops
  def received_loop(control_pid, client_socket) do
    received_data(control_pid, client_socket,
                  :gen_tcp.recv(client_socket, 0))
  end

  def received_data(control_pid, client_socket, {:ok, "ping\r\n"}) do
    IO.puts "PING #{inspect client_socket}"
    :gen_tcp.send(client_socket, "pong\n")
    received_loop(control_pid, client_socket)
  end

  def received_data(control_pid, client_socket, {:ok, combination}) do
    combination
      |> String.trim
      |> try_combination(client_socket)

    received_loop(control_pid, client_socket)
  end

  def received_data(_, client_socket, {:error, :closed}) do
    :gen_tcp.close(client_socket)
    IO.puts "CLOSED #{inspect client_socket}"
  end

  def try_combination(combination, client_socket) do
    IO.puts "DATA #{inspect combination}"
    {_, message} = LockedProcess.pick_lock("test", combination)

    :gen_tcp.send(client_socket, message)
  end


end
