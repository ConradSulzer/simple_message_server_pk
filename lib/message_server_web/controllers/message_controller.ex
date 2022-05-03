defmodule MessageServerWeb.MessageController do
  @moduledoc false

  use MessageServerWeb, :controller

  alias MessageServer.{MessageBucket, BucketSupervisor}

  def index(conn, %{"queue" => bucket, "message" => message}) do
    with {:error, {:already_started, pid}} <- BucketSupervisor.start_bucket({bucket, message}) do
      MessageBucket.add_message(pid, message)
    end

    send_resp(conn, 200, "Received.")
  end
end
