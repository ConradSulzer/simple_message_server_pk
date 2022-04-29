defmodule MessageServer.BucketSupervisor do
  @moduledoc """
  Supervisor for the individual message buckets.
  """

  use DynamicSupervisor

  alias MessageServer.MessageBucket

  def start_link(arg),
    do: DynamicSupervisor.start_link(__MODULE__, arg, name: __MODULE__)

  def init(_arg),
    do: DynamicSupervisor.init(strategy: :one_for_one)

  def start_bucket(params),
    do: DynamicSupervisor.start_child(__MODULE__, {MessageBucket, params})
end
