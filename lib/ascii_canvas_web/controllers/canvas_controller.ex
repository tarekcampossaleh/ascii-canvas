defmodule AsciiCanvasWeb.CanvasController do
  use AsciiCanvasWeb, :controller

  alias AsciiCanvas.{CanvasSchema, DrawingModel, CanvasModel, Repo}

  @outline_fill_error "One of either Fill or Outline should always be present or should always have byte_size lenght of 1"
  @flood_fill_error "Fill should always be present or should always have byte_size lenght of 1 in flood_fill drawings"

  @doc "http post method to handle /canvas conn with given arguments of a retangle, flood_fill or without body to create a blank 50x25 canvas"
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
    if (fill == "" and outline == "") or byte_size("#{outline}") > 1 or byte_size("#{fill}") > 1 do
      conn
      |> put_status(:precondition_failed)
      |> render("error.json", message: @outline_fill_error)
    else
      outline =
        if outline == "" do
          _outline = fill
        else
          outline
        end

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
  end

  def write_canvas(conn, %{
        "flood_fill" => %{
          "id" => id,
          "x" => x,
          "y" => y,
          "fill_char" => fill
        }
      }) do
    if fill == "" or byte_size("#{fill}") > 1 do
      conn
      |> put_status(:precondition_failed)
      |> render("error.json", message: @flood_fill_error)
    else
      case Repo.get(CanvasSchema, id) do
        nil ->
          {:ok, canvas} = CanvasModel.create_blank_value()

          {:ok, new_canvas} = DrawingModel.drawing_flood(canvas.id, x, y, fill)

          conn
          |> put_status(:created)
          |> render("canvas.json", %{canvas_id: new_canvas.id, value: new_canvas.value})

        canvas ->
          {:ok, new_canvas} = DrawingModel.drawing_flood(canvas.id, x, y, fill)

          conn
          |> put_status(:ok)
          |> render("canvas.json", %{canvas_id: new_canvas.id, value: new_canvas.value})
      end
    end
  end

  def write_canvas(conn, %{}) do
    {:ok, canvas} = CanvasModel.create_blank_value()

    conn
    |> put_status(:created)
    |> render("canvas_created.json", %{canvas_id: canvas.id, value: canvas.value})
  end
end
