defmodule KlinikSubhaAdminWeb.PageController do
  use KlinikSubhaAdminWeb, :controller

  def index(conn, _params) do
    text(conn, "Welcome to KlinikSubhaAdmin!")
  end
end
