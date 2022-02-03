defmodule AsciiCanvas.CanvasModel do
  alias AsciiCanvas.Repo
  alias AsciiCanvas.CanvasSchema, as: Canvas

  defp create(params) do
    %Canvas{}
    |> Canvas.changeset(params)
    |> Repo.insert()
  end

  @doc "Get canvas schema from database by a given id"
  def get_canvas(id), do: Repo.get(Canvas, id)

  @doc "Updates a canvas value by given id"
  def update(canvas_id, value) do
    get_canvas(canvas_id)
    |> Ecto.Changeset.change(value: value)
    |> Repo.update()
  end

  @doc "Creates and insert a blank 50x25 canvas"
  def create_blank_value() do
    create(%{value: List.duplicate(String.duplicate(" ", 50), 25)})
  end
end
