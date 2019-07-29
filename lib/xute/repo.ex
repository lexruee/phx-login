defmodule Xute.Repo do
  use Ecto.Repo,
    otp_app: :xute,
    adapter: Ecto.Adapters.Postgres
end
