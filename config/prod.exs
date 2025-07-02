import Config

config :klinik_subha_admin, KlinikSubhaAdminWeb.Endpoint,
  url: [host: System.get_env("PHX_HOST") || "example.com", port: 443, scheme: "https"],
  http: [port: 4000],
  secret_key_base: System.get_env("SECRET_KEY_BASE"),
  server: true,
  cache_static_manifest: "priv/static/cache_manifest.json"

config :logger, level: :info

config :phoenix, :json_library, Jason

config :klinik_subha_admin, KlinikSubhaAdmin.Repo,
  username: System.get_env("DB_USERNAME") || "postgres",
  password: System.get_env("DB_PASSWORD") || "naeem1910",
  hostname: System.get_env("DB_HOST") || "localhost",
  database: System.get_env("DB_NAME") || "klinik_subha_admin_prod",
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10"),
  ssl: true
