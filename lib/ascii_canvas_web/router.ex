defmodule AsciiCanvasWeb.Router do
  use AsciiCanvasWeb, :router

  alias AsciiCanvasWeb.CanvasController
  alias AsciiCanvasWeb.ShowCanvasController

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {AsciiCanvasWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", AsciiCanvasWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/" do
    pipe_through [:api]

    post "/canvas", CanvasController, :write_canvas
  end

  scope "/" do
    pipe_through [:browser]

    live "/canvas/:id", ShowCanvasController
  end

  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: AsciiCanvasWeb.Telemetry
    end
  end

  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
