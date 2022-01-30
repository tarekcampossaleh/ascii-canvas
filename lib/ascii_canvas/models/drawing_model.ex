defmodule AsciiCanvas.Drawingmodel do
  defp insert_char_at(canvas, x, y, char) do
    # TODO: fix bug when y overflows canvas size
    row =
      Enum.at(canvas, y)
      |> String.split("", trim: true)
      |> List.replace_at(x, char)
      |> Enum.join("")

    canvas = List.replace_at(canvas, y, row)
    canvas
  end

  def write_canvas(canvas, width, height, x, y, outline, fill) do
    Enum.reduce(x..(width + x), canvas, fn i, acc ->
      Enum.reduce(y..(height + y), acc, fn j, inc ->
        if i == x or i == x + width or j == y or j == y + height do
          insert_char_at(inc, i, j, outline)
        else
          if fill == "" do
            inc
          else
            insert_char_at(inc, i, j, fill)
          end
        end
      end)
    end)
  end
end
