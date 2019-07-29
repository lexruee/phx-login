# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :xute,
  ecto_repos: [Xute.Repo]

# Configures the endpoint
config :xute, XuteWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "uDTQTi3HvvXU0S8MWiG6dOUvUEQlYo92zEeAvFuCD14Hi+HGmhk6I7RQS01pD+XW",
  render_errors: [view: XuteWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Xute.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
