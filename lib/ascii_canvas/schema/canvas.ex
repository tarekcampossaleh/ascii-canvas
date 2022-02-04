defmodule AsciiCanvas.CanvasSchema do
  use Ecto.Schema
  import Ecto.Changeset

  schema "canvas" do
    field :value, {:array, :string}
    timestamps()
  end

  def changeset(canvas, params \\ %{}) do
    canvas
    |> cast(params, [:value])
    |> validate_required(:value)

  end
end
