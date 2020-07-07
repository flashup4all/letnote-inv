# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :let_inv,
  ecto_repos: [LetInv.Repo]

# Configures the endpoint
config :let_inv, LetInvWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "FEztSt4VRJbT3pg2EIkWNHZNWgXReyoQSwdKv9+LoOM7lD8dpinZyV0SEVXeFiI5",
  render_errors: [view: LetInvWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: LetInv.PubSub,
  live_view: [signing_salt: "tLB5u6xP"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

config :let_inv, :pow,
  user: LetInv.Users.User,
  repo: LetInv.Repo,
  mailer_backend: LetInv.Mailer,
  extensions: [PowResetPassword, PowEmailConfirmation],
  controller_callbacks: Pow.Extension.Phoenix.ControllerCallbacks,
  web_module: LetInvWeb,
  routes_backend: LetInvWeb.Pow.Routes

  config :let_inv, LetInv.Mailer,
    adapter: Swoosh.Adapters.Mailgun,
    api_key: "9825c1146b146f8d0d3c1bfc83bfcbef-f877bd7a-db48ca29",
    domain: "mailgun.rentch.ng"
    