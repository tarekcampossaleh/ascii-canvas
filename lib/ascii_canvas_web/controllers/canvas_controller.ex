defmodule AsciiCanvasWeb.CanvasController do
  use AsciiCanvasWeb, :controller

  alias AsciiCanvas.{CanvasSchema, DrawingModel, CanvasModel, Repo}

  def write_canvas(conn, %{
        "retangle" => %{
          "id" => id,
          "width" => width,
          "height" => height,
          "x" => x,
          "y" => y,
          "outline_char" => outline,
          "fill_char" => fill
        }
      }) do
    case Repo.get(CanvasSchema, id) do
      nil ->
        {:ok, canvas} = CanvasModel.create_blank_value()
        {:ok, new_canvas} = DrawingModel.drawing(canvas.id, width, height, x, y, outline, fill)

        conn
        |> put_status(:created)
        |> render("canvas.json", %{canvas_id: new_canvas.id, value: new_canvas.value})

      canvas ->
        {:ok, new_canvas} = DrawingModel.drawing(canvas.id, width, height, x, y, outline, fill)

        conn
        |> put_status(:ok)
        |> render("canvas.json", %{canvas_id: new_canvas.id, value: new_canvas.value})
    end
  end

  #  def write_canvas(conn, %{}) do 
  #  render(conn, "teste.json", %{})
  # end
end
