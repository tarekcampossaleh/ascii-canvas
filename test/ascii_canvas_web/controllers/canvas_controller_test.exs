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
  @flood_fill %{
    "flood_fill" => %{
      "id" => 1,
      "x" => 0,
      "y" => 0,
      "fill_char" => "-"
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

    test "post /canvas Flood fill at [0, 0] with fill character -", %{conn: conn} do
      conn = post(conn, Routes.canvas_path(conn, :write_canvas), @flood_fill)
      res = json_response(conn, 201)

      assert res == %{
               "data" => %{
                 "canvas" => [
                   "--------------------------------------------------",
                   "--------------------------------------------------",
                   "--------------------------------------------------",
                   "--------------------------------------------------",
                   "--------------------------------------------------",
                   "--------------------------------------------------",
                   "--------------------------------------------------",
                   "--------------------------------------------------",
                   "--------------------------------------------------",
                   "--------------------------------------------------",
                   "--------------------------------------------------",
                   "--------------------------------------------------",
                   "--------------------------------------------------",
                   "--------------------------------------------------",
                   "--------------------------------------------------",
                   "--------------------------------------------------",
                   "--------------------------------------------------",
                   "--------------------------------------------------",
                   "--------------------------------------------------",
                   "--------------------------------------------------",
                   "--------------------------------------------------",
                   "--------------------------------------------------",
                   "--------------------------------------------------",
                   "--------------------------------------------------",
                   "--------------------------------------------------"
                 ],
                 "canvas_id" => res["data"]["canvas_id"]
               }
             }
    end

    test "post /canvas retangle with fill none", %{conn: conn} do
      conn =
        post(conn, Routes.canvas_path(conn, :write_canvas), %{
          "retangle" => %{
            "id" => 1,
            "width" => 14,
            "height" => 6,
            "x" => 10,
            "y" => 3,
            "outline_char" => "X",
            "fill_char" => ""
          }
        })

      res = json_response(conn, 201)

      assert res == %{
               "data" => %{
                 "canvas" => [
                   "                                                  ",
                   "                                                  ",
                   "                                                  ",
                   "          XXXXXXXXXXXXXXX                         ",
                   "          X             X                         ",
                   "          X             X                         ",
                   "          X             X                         ",
                   "          X             X                         ",
                   "          X             X                         ",
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

    test "post /canvas retangle with outline none", %{conn: conn} do
      conn =
        post(conn, Routes.canvas_path(conn, :write_canvas), %{
          "retangle" => %{
            "id" => 1,
            "width" => 14,
            "height" => 6,
            "x" => 10,
            "y" => 3,
            "outline_char" => "",
            "fill_char" => "X"
          }
        })

      res = json_response(conn, 201)

      assert res == %{
               "data" => %{
                 "canvas" => [
                   "                                                  ",
                   "                                                  ",
                   "                                                  ",
                   "          XXXXXXXXXXXXXXX                         ",
                   "          XXXXXXXXXXXXXXX                         ",
                   "          XXXXXXXXXXXXXXX                         ",
                   "          XXXXXXXXXXXXXXX                         ",
                   "          XXXXXXXXXXXXXXX                         ",
                   "          XXXXXXXXXXXXXXX                         ",
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

    test "post /canvas retangle with outline and fill none", %{conn: conn} do
      conn =
        post(conn, Routes.canvas_path(conn, :write_canvas), %{
          "retangle" => %{
            "id" => 1,
            "width" => 14,
            "height" => 6,
            "x" => 10,
            "y" => 3,
            "outline_char" => "",
            "fill_char" => ""
          }
        })

      res = json_response(conn, 201)

      refute res == %{
               "data" => %{
                 "canvas" => [
                   "                                                  ",
                   "                                                  ",
                   "                                                  ",
                   "                                  ",
                   "                                                ",
                   "                                                ",
                   "                                                ",
                   "                                                ",
                   "                                                ",
                   "                                  ",
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

    test "post /canvas retangle with outline with lenght higher then 1", %{conn: conn} do
      conn =
        post(conn, Routes.canvas_path(conn, :write_canvas), %{
          "retangle" => %{
            "id" => 1,
            "width" => 14,
            "height" => 6,
            "x" => 10,
            "y" => 3,
            "outline_char" => "XXX",
            "fill_char" => "X"
          }
        })

      res = json_response(conn, 201)

      refute res == %{
               "data" => %{
                 "canvas" => [
                   "                                                  ",
                   "                                                  ",
                   "                                                  ",
                   "          XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX                                       ",
                   "          XXXXXXXXXXXXXXXXX                           ",
                   "          XXXXXXXXXXXXXXXXX                           ",
                   "          XXXXXXXXXXXXXXXXX                           ",
                   "          XXXXXXXXXXXXXXXXX                           ",
                   "          XXXXXXXXXXXXXXXXX                           ",
                   "          XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX                                       ",
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
