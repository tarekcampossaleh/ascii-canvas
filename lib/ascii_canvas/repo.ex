defmodule AsciiCanvas.Repo do
  use Ecto.Repo,
    otp_app: :ascii_canvas,
    adapter: Ecto.Adapters.Postgres
end
