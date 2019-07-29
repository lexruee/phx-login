defmodule XuteWeb.Auth do
  alias XuteWeb.Router.Helpers, as: Routes
  alias Xute.Accounts.User

  import Phoenix.Controller, only: [put_flash: 3, redirect: 2]
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    user_id = get_session(conn, :user_id)
    user = user_id && Xute.Accounts.get_user(user_id)
    assign(conn, :current_user, user)
  end

  def login(conn, user) do
    conn
    |> assign(:current_user, user)
    |> put_session(:user_id, user.id)
    |> configure_session(renew: true)
  end

  def logout(conn) do
    conn
    |> configure_session(drop: true)
  end

  def authenticate_user(conn, _opts) do
    case conn.assigns.current_user do
      %User{} -> conn
      _ -> user_authentication_error(conn)
    end
  end

  def user_authentication_error(conn) do
    conn
    |> put_flash(:error, "You must be logged in to access that page!")
    |> redirect(to: Routes.page_path(conn, :index))
    |> halt()
  end
end