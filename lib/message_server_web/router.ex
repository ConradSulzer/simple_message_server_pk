defmodule MessageServerWeb.Router do
  @moduledoc false

  use MessageServerWeb, :router

  scope "/", MessageServerWeb do
    get "/receive-message", MessageController, :index
  end
end
