defmodule AsciiCanvasWeb.CanvasControllerTest do
  use AsciiCanvasWeb.ConnCase

  @canvas %{
    "retangle" => %{
      "id" => 1,
      "width" => 5,
      "height" => 3,
      "x" => 3,
      "y" => 2,
      "outline_char" => "@",
      "fill_char" => "X"
    }
  }

  describe "Canvas Controller:" do
    test "post /canvas retangle [3,2] w: 5 h: 3, outline: @, fill: X", %{conn: conn} do
      conn = post(conn, Routes.canvas_path(conn, :write_canvas), @canvas)
      res = json_response(conn, 201)

      assert res == %{
               "data" => %{
                 "canvas" => [
                   "                                                  ",
                   "                                                  ",
                   "   @@@@@@                                         ",
                   "   @XXXX@                                         ",
                   "   @XXXX@                                         ",
                   "   @@@@@@                                         ",
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
                 ],
                 "canvas_id" => res["data"]["canvas_id"]
               }
             }
    end

    test "post /canvas mesh retangle", %{conn: conn} do
      conn = post(conn, Routes.canvas_path(conn, :write_canvas), @canvas)
      res = json_response(conn, 201)

      conn =
        post(conn, Routes.canvas_path(conn, :write_canvas), %{
          "retangle" => %{
            "id" => res["data"]["canvas_id"],
            "width" => 14,
            "height" => 6,
            "x" => 10,
            "y" => 3,
            "outline_char" => "X",
            "fill_char" => "O"
          }
        })

      res = json_response(conn, 200)

      assert res == %{
               "data" => %{
                 "canvas" => [
                   "                                                  ",
                   "                                                  ",
                   "   @@@@@@                                         ",
                   "   @XXXX@ XXXXXXXXXXXXXXX                         ",
                   "   @XXXX@ XOOOOOOOOOOOOOX                         ",
                   "   @@@@@@ XOOOOOOOOOOOOOX                         ",
                   "          XOOOOOOOOOOOOOX                         ",
                   "          XOOOOOOOOOOOOOX                         ",
                   "          XOOOOOOOOOOOOOX                         ",
                   "          XXXXXXXXXXXXXXX                         ",
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
                 ],
                 "canvas_id" => res["data"]["canvas_id"]
               }
             }
    end
  end
end
