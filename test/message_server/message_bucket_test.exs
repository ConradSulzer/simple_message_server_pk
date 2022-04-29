defmodule MessageServer.MessageBucketTest do
  use ExUnit.Case

  alias MessageServer.{BucketSupervisor, MessageBucket}

  setup do
    time = Timex.beginning_of_day(Timex.now())
    bucket = System.unique_integer([:positive])

    BucketSupervisor.start_bucket({bucket, "test message 0", Timex.shift(time, seconds: -1)})

    [{pid, _}] = Registry.lookup(BucketRegistry, "#{bucket}")

    {:ok, %{time: time, pid: pid, bucket: bucket}}
  end

  test "Prints a new message for a bucket", %{
    time: time,
    pid: pid,
    bucket: bucket
  } do
    params = {bucket, "test message 1", time}

    assert :processed == MessageBucket.handle_message(pid, params)
  end

  test "Does not print the new message for a bucket if message arrives less than a second after the previous print",
       %{
         time: time,
         pid: pid,
         bucket: bucket
       } do
    params_one = {bucket, "test message 2", time}
    params_two = {bucket, "test message 3", Timex.shift(time, milliseconds: 999)}

    assert :processed == MessageBucket.handle_message(pid, params_one)
    assert :not_processed == MessageBucket.handle_message(pid, params_two)
  end

  test "Will print the message for a bucket after one second has passed from previous print", %{
    time: time,
    pid: pid,
    bucket: bucket
  } do
    params_one = {bucket, "test message 4", Timex.shift(time, milliseconds: 500)}
    params_two = {bucket, "test message 5", Timex.shift(time, milliseconds: 1500)}

    assert :processed == MessageBucket.handle_message(pid, params_one)
    assert :processed == MessageBucket.handle_message(pid, params_two)
  end
end
