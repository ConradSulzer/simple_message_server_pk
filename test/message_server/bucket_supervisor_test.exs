defmodule MessageServer.BucketSupervisorTests do
  @moduledoc false

  use ExUnit.Case

  alias MessageServer.BucketSupervisor

  test "Creates a new bucket" do
    assert Registry.lookup(BucketRegistry, "supervisor_test_one") == []

    BucketSupervisor.start_bucket({"supervisor_test_one", "supervisor test message", Timex.now()})

    assert [{pid, _nil}] = Registry.lookup(BucketRegistry, "supervisor_test_one")
    assert is_pid(pid)
  end

  test "start_bucket/1 returns an error if bucket already exists" do
    BucketSupervisor.start_bucket({"supervisor_test_two", "supervisor test message", Timex.now()})

    assert {:error, {:already_started, _pid}} =
             BucketSupervisor.start_bucket(
               {"supervisor_test_two", "supervisor test message", Timex.now()}
             )
  end
end
