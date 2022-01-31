defmodule AsciiCanvasWeb.CanvasView do
  use AsciiCanvasWeb, :view

  def render("canvas.json", %{canvas_id: id, value: value}) do
    %{
      data: %{canvas_id: id, canvas: value}
    }
  end
end
