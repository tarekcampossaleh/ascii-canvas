defmodule AsciiCanvasWeb.CanvasController do
  use AsciiCanvasWeb, :controller

  alias AsciiCanvas.{CanvasSchema, DrawingModel, CanvasModel, Repo}

  # def validate_canvas(outline, fill) do
  #  if fill == "none" and outline == "none" do 
  #    {:error, message: "One of either fill or outline should always be present"}
  #  else 
  #    if fill == "none", do: fill = ""
  #    if outline == "none", do: outline = fill
  #  end
  # end
  #
  #
  def validate(char) when char != "none" do
    if byte_size(char) > 1 do
      false
    else
      true
    end
  end

  @outline_fill_error "One of either Fill or Outline should always be present"
  @byte_size_error "Fill and Outline should always have byte_size lenght of 1"

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
    # TODO: validations of char and outline
    # outline = if outline == "none", do: _outline = fill
    # if fill == "none" and outline == "none", do: render(conn, "error.json", message: @outline_fill_error)
    # if validate(outline) == false or validate(fill) == false, do: render(conn, "error.json", message: @byte_size_error) 

    # render(conn, "error.json", message: message)
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

  def write_canvas(conn, %{}) do
    {:ok, canvas} = CanvasModel.create_blank_value()

    conn
    |> put_status(:created)
    |> render("canvas_created.json", %{canvas_id: canvas.id, value: canvas.value})
  end
end
