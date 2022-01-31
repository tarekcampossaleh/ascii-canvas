defmodule AsciiCanvas.Drawingmodel do
  alias AsciiCanvas.Repo
  alias AsciiCanvas.CanvasSchema

  import AsciiCanvas.CanvasModel

  defp insert_char_at(canvas, x, y, char) do
    row =
      Enum.at(canvas, y)
      |> String.split("", trim: true)
      |> List.replace_at(x, char)
      |> Enum.join("")

    List.replace_at(canvas, y, row)
  end

  defp write_canvas(canvas, width, height, x, y, outline, fill) do
    Enum.reduce(x..(width + x), canvas, fn i, acc ->
      Enum.reduce(y..(height + y), acc, fn j, inc ->
        if j > 24 do
          inc
        else
          if i == x or i == x + width or j == y or j == y + height do
            insert_char_at(inc, i, j, outline)
          else
            if fill == "" do
              inc
            else
              insert_char_at(inc, i, j, fill)
            end
          end
        end
      end)
    end)
  end

  @doc "Draws and update a canvas.value of a given canvas id"
  def drawing(canvas_id, width, height, x, y, outline, fill) do
    canvas = Repo.get(CanvasSchema, canvas_id)
    update(canvas_id, write_canvas(canvas.value, width, height, x, y, outline, fill))
  end
end
