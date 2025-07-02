defmodule KlinikSubhaAdminWeb do
  def controller do
    quote do
      use Phoenix.Controller, namespace: KlinikSubhaAdminWeb

      import Plug.Conn
      import KlinikSubhaAdminWeb.Gettext
      alias KlinikSubhaAdminWeb.Router.Helpers, as: Routes
    end
  end

  def router do
    quote do
      use Phoenix.Router

      import Plug.Conn
      import Phoenix.Controller
    end
  end

  def html do
    quote do
      use Phoenix.Component
    end
  end

  def view do
    quote do
      use Phoenix.View,
        root: "lib/klinik_subha_admin_web/templates",
        namespace: KlinikSubhaAdminWeb

      import Phoenix.Controller,
        only: [get_flash: 1, get_flash: 2, view_module: 1, view_template: 1]

      unquote(html())
    end
  end

  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
