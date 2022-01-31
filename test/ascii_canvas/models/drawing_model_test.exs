defmodule AsciiCanvas.DrawingModelTest do
  use AsciiCanvas.DataCase

  alias AsciiCanvas.CanvasModel
  alias AsciiCanvas.Drawingmodel

  describe "Drawing Model:" do
    test "Rectangle at [14, 0] with width 7, height 6, outline character: ., fill: ." do
      {:ok, canvas} = CanvasModel.create_blank_value()
      {:ok, new_canvas} = Drawingmodel.drawing(canvas.id, 7, 6, 14, 0, ".", ".")

      assert new_canvas.value == [
               "              ........                            ",
               "              ........                            ",
               "              ........                            ",
               "              ........                            ",
               "              ........                            ",
               "              ........                            ",
               "              ........                            ",
               "                                                  ",
               "                                                  ",
               "                                                  ",
               "                                                  ",
               "                                                  ",
               "                                                  ",
               "                                                  ",
               "                                                  ",
               "                                                  ",
               "                                                  ",
               "                                                  ",
               "                                                  ",
               "                                                  ",
               "                                                  ",
               "                                                  ",
               "                                                  ",
               "                                                  ",
               "                                                  "
             ]
    end
  end
end
