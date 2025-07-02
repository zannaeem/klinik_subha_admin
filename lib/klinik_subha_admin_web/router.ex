defmodule KlinikSubhaAdminWeb.Router do
  use KlinikSubhaAdminWeb, :router

  import Phoenix.LiveView.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/", KlinikSubhaAdminWeb do
    pipe_through :browser

    get "/", PageController, :index

    # LiveView CRUD routes
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
end
