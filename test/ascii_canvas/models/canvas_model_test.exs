defmodule AsciiCanvas.CanvasModelTest do
  use AsciiCanvas.DataCase

  alias AsciiCanvas.CanvasModel

  describe "Canvas Model:" do
    test "creates empty canvas" do
      {:ok, canvas} = CanvasModel.create_blank_value()

      assert canvas.value == [
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

    test "update a given canvas" do
      {:ok, canvas} = CanvasModel.create_blank_value()
      {:ok, canvas} = CanvasModel.update(canvas.id, ["T", "E", "S", "T"])

      assert canvas.value == ["T", "E", "S", "T"]
    end
  end
end
