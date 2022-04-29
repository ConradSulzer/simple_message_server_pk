defmodule MessageServer.MessageBucket do
  @moduledoc """
  Genserver to manage the various message buckets.
  """

  use GenServer

  def init({_, message, _} = params) do
    IO.puts(message)
    {:ok, params}
  end

  def handle_call(
        {:new_message, {_, message, new_time} = params},
        _from,
        {_, _, prev_time} = state
      ) do
    if Timex.diff(new_time, prev_time, :seconds) > 0 do
      IO.puts(message)
      {:reply, :processed, params}
    else
      {:reply, :not_processed, state}
    end
  end

  def handle_continue(nil, {_, message, _} = state) do
    IO.puts(message)
    {:noreply, state}
  end

  def start_link({bucket_name, _message, _time} = params),
    do: GenServer.start_link(__MODULE__, params, name: get_name(bucket_name))

  def handle_message(name, params) do
    GenServer.call(name, {:new_message, params})
  end

  defp get_name(name), do: {:via, Registry, {BucketRegistry, "#{name}"}}
end
