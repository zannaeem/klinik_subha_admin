# Klinik Subha Admin Dashboard

A modern Phoenix LiveView application for managing Klinik Subha's administrative operations.

## Features

- **Phoenix LiveView**: Real-time, interactive web interface
- **PostgreSQL Database**: Robust data storage with Ecto ORM
- **Tailwind CSS**: Modern, utility-first CSS framework
- **Live Dashboard**: Built-in Phoenix LiveDashboard for monitoring
- **Responsive Design**: Mobile-friendly interface

## Prerequisites

- Elixir 1.14 or later
- Erlang/OTP 24 or later
- PostgreSQL
- Node.js (for asset compilation)

## Installation

1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd klinik_subha_admin
   ```

2. Install dependencies:
   ```bash
   mix deps.get
   ```

3. Set up the database:
   ```bash
   mix ecto.create
   mix ecto.migrate
   ```

4. Install and build assets:
   ```bash
   mix assets.setup
   mix assets.build
   ```

5. Start the Phoenix server:
   ```bash
   mix phx.server
   ```

The application will be available at [http://localhost:4000](http://localhost:4000).

## Development

### Database Configuration

The database configuration is in `config/dev.exs`. Update the PostgreSQL credentials as needed:

```elixir
config :klinik_subha_admin, KlinikSubhaAdmin.Repo,
  username: "postgres",
  password: "your_password",
  hostname: "localhost",
  database: "klinik_subha_admin_dev"
```

### Useful Commands

- `mix phx.server` - Start the development server
- `mix ecto.migrate` - Run database migrations
- `mix ecto.reset` - Reset the database
- `mix test` - Run tests
- `mix assets.build` - Build assets for production
- `mix deps.get` - Install dependencies

### Project Structure

```
lib/
├── klinik_subha_admin/          # Business logic
│   ├── accounts/               # User management
│   ├── repo.ex                 # Database configuration
│   └── application.ex          # Application supervision
└── klinik_subha_admin_web/     # Web interface
    ├── controllers/            # HTTP controllers
    ├── live/                   # LiveView modules
    ├── components/             # Reusable components
    └── router.ex               # URL routing
```

## Deployment

For production deployment, set the following environment variables:

- `DATABASE_URL` - PostgreSQL connection string
- `SECRET_KEY_BASE` - Secret key for session encryption
- `PHX_HOST` - Application hostname

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests
5. Submit a pull request

## License

This project is licensed under the MIT License.
