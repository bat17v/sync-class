defmodule SyncClassWeb.PageController do
  use SyncClassWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
