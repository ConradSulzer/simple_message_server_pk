defmodule MessageServerWeb.MessageControllerTest do
  use MessageServerWeb.ConnCase

  setup do
    conn = build_conn()

    {:ok, %{conn: conn}}
  end

  test "GET /receive-message returns a 200 response", %{conn: conn} do
    conn =
      get(
        conn,
        MessageServerWeb.Router.Helpers.message_path(conn, :index, %{
          "queue" => "test",
          "message" => "test 1"
        })
      )

    assert response(conn, 200)
  end
end
