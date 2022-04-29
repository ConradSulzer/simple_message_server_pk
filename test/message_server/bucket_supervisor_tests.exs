defmodule MessageServer.BucketSupervisorTests do
  use ExUnit.Case

  alias MessageServer.BucketSupervisor

  test "Creates a new bucket" do
    # Not in registry
    assert Registry.lookup(BucketRegistry, "supervisor_test") == []

    BucketSupervisor.start_bucket({"supervisor_test", "supervisor test message", Timex.now()})

    # Now in registry
    assert [{pid, _nil}] = Registry.lookup(BucketRegistry, "supervisor_test")
    assert is_pid(pid)
  end
end
