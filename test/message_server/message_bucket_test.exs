defmodule MessageServer.MessageBucketTest do
  @moduledoc false

  use ExUnit.Case

  import ExUnit.CaptureIO

  alias MessageServer.MessageBucket

  test "init/1 returns {:continue, :print_message}" do
    assert {:ok, "test message", {:continue, :print_message}} ==
             MessageBucket.init("test message")
  end

  test "handle_cast/2 returns {:continue, :print_message}" do
    assert {:noreply, "test message", {:continue, :print_message}} ==
             MessageBucket.handle_cast({:new_message, "test message"}, nil)
  end

  test "handle_continue/2 prints message to terminal and blocks for one second" do
    time = Timex.now()
    result = capture_io(fn -> MessageBucket.handle_continue(:print_message, "test message") end)
    time_after = Timex.now()

    assert result == "test message\n"
    assert 1 == Timex.diff(time_after, time, :seconds)
  end
end
