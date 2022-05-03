defmodule MessageServer.MessageBucket do
  @moduledoc """
  Genserver to manage the various message buckets.
  """

  use GenServer, restart: :transient

  def init(message) do
    {:ok, message, {:continue, :print_message}}
  end

  def handle_cast({:new_message, message}, _state) do
    {:noreply, message, {:continue, :print_message}}
  end

  def handle_continue(:print_message, message) do
    IO.puts(message)
    Process.sleep(1000)
    {:noreply, nil, 0}
  end

  def handle_info(:timeout, state) do
    {:stop, :normal, state}
  end

  def start_link({bucket_name, message}),
    do: GenServer.start_link(__MODULE__, message, name: create_name(bucket_name))

  def add_message(name, message) do
    GenServer.cast(name, {:new_message, message})
  end

  defp create_name(name), do: {:via, Registry, {BucketRegistry, "#{name}"}}
end
