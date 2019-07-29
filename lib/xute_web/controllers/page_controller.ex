defmodule XuteWeb.PageController do
  use XuteWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
