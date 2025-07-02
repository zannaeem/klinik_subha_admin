defmodule KlinikSubhaAdminWeb.Router do
  use KlinikSubhaAdminWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {KlinikSubhaAdminWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", KlinikSubhaAdminWeb do
    pipe_through :browser

    get "/", PageController, :home

    # Booking System Routes
    live "/patients", PatientLive.Index, :index
    live "/patients/new", PatientLive.Index, :new
    live "/patients/:id/edit", PatientLive.Index, :edit
    live "/patients/:id", PatientLive.Show, :show
    live "/patients/:id/show/edit", PatientLive.Show, :edit

    live "/doctors", DoctorLive.Index, :index
    live "/doctors/new", DoctorLive.Index, :new
    live "/doctors/:id/edit", DoctorLive.Index, :edit
    live "/doctors/:id", DoctorLive.Show, :show
    live "/doctors/:id/show/edit", DoctorLive.Show, :edit

    live "/appointments", AppointmentLive.Index, :index
    live "/appointments/new", AppointmentLive.Index, :new
    live "/appointments/:id/edit", AppointmentLive.Index, :edit
    live "/appointments/:id", AppointmentLive.Show, :show
    live "/appointments/:id/show/edit", AppointmentLive.Show, :edit
  end

  # Other scopes may use custom stacks.
  # scope "/api", KlinikSubhaAdminWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:klinik_subha_admin, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: KlinikSubhaAdminWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
