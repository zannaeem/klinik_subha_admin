import Config

config :klinik_subha_admin, KlinikSubhaAdmin.Repo,
  username: "postgres",
  password: "naeem1910",
  hostname: "localhost",
  database: "klinik_subha_admin_dev",
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

config :klinik_subha_admin, KlinikSubhaAdminWeb.Endpoint,
  url: [host: "localhost"],
  http: [port: 4000],
  secret_key_base: "8VJCZh0l+KJmKw66RA9IZLHNuCcRhXOyV6PPlnN2OdNAj8V4HgmPJPmesEuq/CN+",
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: []

config :klinik_subha_admin,
  ecto_repos: [KlinikSubhaAdmin.Repo]
