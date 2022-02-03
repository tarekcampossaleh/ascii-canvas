defmodule AsciiCanvasWeb.ShowCanvasController do
  use Phoenix.LiveView

  alias AsciiCanvas.CanvasModel

  def mount(params, _session, socket) do
    canvas = CanvasModel.get_canvas(params["id"])
    canvas = %{id: canvas.id, value: Enum.join(canvas.value, "\n")}
    {:ok, assign(socket, :canvas, canvas)}
  end

  def render(assigns) do
    Phoenix.View.render(AsciiCanvasWeb.PageView, "show.html", assigns)
  end
end
