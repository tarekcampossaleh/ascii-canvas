ExUnit.start()
ExUnit.configure(exclude: :pending, trace: true, seed: 0)
Ecto.Adapters.SQL.Sandbox.mode(AsciiCanvas.Repo, :manual)
