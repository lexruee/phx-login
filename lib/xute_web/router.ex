defmodule XuteWeb.Router do
  use XuteWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug XuteWeb.Auth
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", XuteWeb do
    pipe_through :browser

    resources "/session", SessionController, only: [:new, :create, :delete]
    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", XuteWeb do
  #   pipe_through :api
  # end
end
