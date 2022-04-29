import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :message_server, MessageServerWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "Lro9RVNWvSjgG2PoWEO637clryzm/0OtrSbibK69I1N3hGWwRSGgzotU/8OruroR",
  server: false

# In test we don't send emails.
config :message_server, MessageServer.Mailer,
  adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
