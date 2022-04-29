defmodule MessageServerWeb.MessageController do
  @moduledoc false

  use MessageServerWeb, :controller

  alias MessageServer.{MessageBucket, BucketSupervisor}

  def index(conn, %{"queue" => bucket, "message" => message}) do
    params = {bucket, message, DateTime.utc_now()}

    with {:error, {:already_started, pid}} <- BucketSupervisor.start_bucket(params) do
      MessageBucket.handle_message(pid, params)
    end

    send_resp(conn, 200, "Received.")
  end
end
