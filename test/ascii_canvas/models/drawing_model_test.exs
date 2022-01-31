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

    test "Rectangle at [0, 3] with width 8, height 4, outline character: 0, fill: none" do
      {:ok, canvas} = CanvasModel.create_blank_value()
      {:ok, new_canvas} = Drawingmodel.drawing(canvas.id, 8, 4, 0, 3, "0", "")

      assert new_canvas.value == [
               "                                                  ",
               "                                                  ",
               "                                                  ",
               "000000000                                         ",
               "0       0                                         ",
               "0       0                                         ",
               "0       0                                         ",
               "000000000                                         ",
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

    test "Rectangle at [5, 5] with width 5, height 3, outline character: X, fill: ~" do
      {:ok, canvas} = CanvasModel.create_blank_value()
      {:ok, new_canvas} = Drawingmodel.drawing(canvas.id, 5, 3, 5, 5, "X", "~")

      assert new_canvas.value == [
               "                                                  ",
               "                                                  ",
               "                                                  ",
               "                                                  ",
               "                                                  ",
               "     XXXXXX                                       ",
               "     X~~~~X                                       ",
               "     X~~~~X                                       ",
               "     XXXXXX                                       ",
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

    test "Mesh of 3 Retangle's" do
      {:ok, canvas} = CanvasModel.create_blank_value()
      {:ok, new_canvas} = Drawingmodel.drawing(canvas.id, 7, 6, 14, 0, ".", ".")
      {:ok, new_canvas} = Drawingmodel.drawing(canvas.id, 8, 4, 0, 3, "0", "")
      {:ok, new_canvas} = Drawingmodel.drawing(canvas.id, 5, 3, 5, 5, "X", "~")

      assert new_canvas.value == [
               "              ........                            ",
               "              ........                            ",
               "              ........                            ",
               "000000000     ........                            ",
               "0       0     ........                            ",
               "0    XXXXXX   ........                            ",
               "0    X~~~~X   ........                            ",
               "00000X~~~~X                                       ",
               "     XXXXXX                                       ",
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

    test "Wrong order Mesh of 3 Retangle's" do
      {:ok, canvas} = CanvasModel.create_blank_value()
      {:ok, new_canvas} = Drawingmodel.drawing(canvas.id, 7, 6, 14, 0, ".", ".")
      {:ok, new_canvas} = Drawingmodel.drawing(canvas.id, 8, 4, 0, 3, "0", "")
      {:ok, new_canvas} = Drawingmodel.drawing(canvas.id, 5, 3, 5, 5, "X", "~")

      refute new_canvas.value == [
               "              ........                            ",
               "              ........                            ",
               "              ........                            ",
               "000000000     ........                            ",
               "0       0     ........                            ",
               "0    XXX0XX   ........                            ",
               "0    X~~0~X   ........                            ",
               "000000000~X                                       ",
               "     XXXXXX                                       ",
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

    test "any kind of ascii utf-8 " do
      {:ok, canvas} = CanvasModel.create_blank_value()
      {:ok, new_canvas} = Drawingmodel.drawing(canvas.id, 7, 6, 14, 0, "Ø", "¼")
      {:ok, new_canvas} = Drawingmodel.drawing(canvas.id, 10, 10, 15, 10, "±", "æ")

      assert new_canvas.value == [
               "              ØØØØØØØØ                            ",
               "              Ø¼¼¼¼¼¼Ø                            ",
               "              Ø¼¼¼¼¼¼Ø                            ",
               "              Ø¼¼¼¼¼¼Ø                            ",
               "              Ø¼¼¼¼¼¼Ø                            ",
               "              Ø¼¼¼¼¼¼Ø                            ",
               "              ØØØØØØØØ                            ",
               "                                                  ",
               "                                                  ",
               "                                                  ",
               "               ±±±±±±±±±±±                        ",
               "               ±æææææææææ±                        ",
               "               ±æææææææææ±                        ",
               "               ±æææææææææ±                        ",
               "               ±æææææææææ±                        ",
               "               ±æææææææææ±                        ",
               "               ±æææææææææ±                        ",
               "               ±æææææææææ±                        ",
               "               ±æææææææææ±                        ",
               "               ±æææææææææ±                        ",
               "               ±±±±±±±±±±±                        ",
               "                                                  ",
               "                                                  ",
               "                                                  ",
               "                                                  "
             ]
    end

    test "outline as number" do
      {:ok, canvas} = CanvasModel.create_blank_value()
      {:ok, new_canvas} = Drawingmodel.drawing(canvas.id, 7, 6, 14, 0, 3, "X")

      assert new_canvas.value == [
               "              33333333                            ",
               "              3XXXXXX3                            ",
               "              3XXXXXX3                            ",
               "              3XXXXXX3                            ",
               "              3XXXXXX3                            ",
               "              3XXXXXX3                            ",
               "              33333333                            ",
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

    test "fill as number" do
      {:ok, canvas} = CanvasModel.create_blank_value()
      {:ok, new_canvas} = Drawingmodel.drawing(canvas.id, 7, 6, 14, 0, "X", 3)

      assert new_canvas.value == [
               "              XXXXXXXX                            ",
               "              X333333X                            ",
               "              X333333X                            ",
               "              X333333X                            ",
               "              X333333X                            ",
               "              X333333X                            ",
               "              XXXXXXXX                            ",
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
