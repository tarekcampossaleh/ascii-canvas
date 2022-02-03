defmodule AsciiCanvasWeb.ShowCanvasController do
  use Phoenix.LiveView

  alias AsciiCanvas.CanvasModel

  def mount(params, _session, socket) do
    if connected?(socket), do: Process.send_after(self(), :update, 2000)

    canvas = CanvasModel.get_canvas(params["id"])
    canvas = %{id: canvas.id, value: Enum.join(canvas.value, "\n")}
    {:ok, assign(socket, :canvas, canvas)}
  end

  def handle_info(:update, socket) do
    Process.send_after(self(), :update, 2000)
    canvas = CanvasModel.get_canvas(socket.assigns.canvas.id)
    canvas = %{id: canvas.id, value: Enum.join(canvas.value, "\n")}
    {:noreply, assign(socket, :canvas, canvas)}
  end

  def render(assigns) do
    Phoenix.View.render(AsciiCanvasWeb.PageView, "show.html", assigns)
  end
end
