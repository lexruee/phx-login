defmodule XuteWeb.SessionController do
  use XuteWeb, :controller

  alias Xute.Accounts
  alias XuteWeb.Auth

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, %{"session" => %{ "username" => username, "password" => password}}) do
    case Accounts.authenticate_by_username_and_password(username, password) do
      {:ok, user} ->
        conn
        |> Auth.login(user)
        |> put_flash(:info, "Welcome back, #{user.username}!")
        |> redirect(to: Routes.page_path(conn, :index))
      {:error, _reason} ->
        conn
        |> put_flash(:error, "Wrong username/password combination!")
        |> render("new.html")
    end
  end

  def delete(conn, _params) do
    conn
    |> Auth.logout()
    |> redirect(to: Routes.page_path(conn, :index))
  end
end