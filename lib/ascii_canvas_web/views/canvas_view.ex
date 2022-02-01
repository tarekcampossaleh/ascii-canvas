defmodule AsciiCanvasWeb.CanvasView do
  use AsciiCanvasWeb, :view

  def render("canvas.json", %{canvas_id: id, value: value}) do
    %{
      data: %{canvas_id: id, canvas: value}
    }
  end

  def render("canvas_created.json", %{canvas_id: id, value: value}) do
    %{
      data: %{canvas_id: id, canvas: value, message: "Canvas of id: #{id} created"}
    }
  end

  def render("error.json", %{message: message}) do
    %{
      data: %{error: message}
    }
  end
end
