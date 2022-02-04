defmodule AsciiCanvasWeb.CanvasControllerTest do
  use AsciiCanvasWeb.ConnCase

  @canvas %{
    "rectangle" => %{
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
    test "post /canvas rectangle [3,2] w: 5 h: 3, outline: @, fill: X", %{conn: conn} do
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

    test "post /canvas mesh rectangle", %{conn: conn} do
      conn = post(conn, Routes.canvas_path(conn, :write_canvas), @canvas)
      res = json_response(conn, 201)

      conn =
        post(conn, Routes.canvas_path(conn, :write_canvas), %{
          "rectangle" => %{
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

    test "post /canvas rectangle with fill none", %{conn: conn} do
      conn =
        post(conn, Routes.canvas_path(conn, :write_canvas), %{
          "rectangle" => %{
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

    test "post /canvas rectangle with outline none", %{conn: conn} do
      conn =
        post(conn, Routes.canvas_path(conn, :write_canvas), %{
          "rectangle" => %{
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

    test "post /canvas rectangle with outline and fill none", %{conn: conn} do
      conn =
        post(conn, Routes.canvas_path(conn, :write_canvas), %{
          "rectangle" => %{
            "id" => 1,
            "width" => 14,
            "height" => 6,
            "x" => 10,
            "y" => 3,
            "outline_char" => "",
            "fill_char" => ""
          }
        })

      res = json_response(conn, 412)

      assert res == %{
               "data" => %{
                 "error" =>
                   "One of either Fill or Outline should always be present or should always have byte_size lenght of 1"
               }
             }

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

    test "post /canvas rectangle with outline with lenght higher then 1", %{conn: conn} do
      conn =
        post(conn, Routes.canvas_path(conn, :write_canvas), %{
          "rectangle" => %{
            "id" => 1,
            "width" => 14,
            "height" => 6,
            "x" => 10,
            "y" => 3,
            "outline_char" => "XXX",
            "fill_char" => "X"
          }
        })

      res = json_response(conn, 412)

      assert res == %{
               "data" => %{
                 "error" =>
                   "One of either Fill or Outline should always be present or should always have byte_size lenght of 1"
               }
             }

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

    test "post /canvas rectangle with outline and fill with lenght higher then 1", %{conn: conn} do
      conn =
        post(conn, Routes.canvas_path(conn, :write_canvas), %{
          "rectangle" => %{
            "id" => 1,
            "width" => 14,
            "height" => 6,
            "x" => 10,
            "y" => 3,
            "outline_char" => "XXX",
            "fill_char" => "XXX"
          }
        })

      res = json_response(conn, 412)

      assert res == %{
               "data" => %{
                 "error" =>
                   "One of either Fill or Outline should always be present or should always have byte_size lenght of 1"
               }
             }
    end

    test "post /canvas flood_fill with fill none", %{conn: conn} do
      conn =
        post(conn, Routes.canvas_path(conn, :write_canvas), %{
          "flood_fill" => %{
            "id" => 1,
            "x" => 0,
            "y" => 0,
            "fill_char" => ""
          }
        })

      res = json_response(conn, 412)

      assert res == %{
               "data" => %{
                 "error" =>
                   "Fill should always be present or should always have byte_size lenght of 1 in flood_fill drawings"
               }
             }
    end

    test "post /canvas flood_fill with fill with lenght higher then 1", %{conn: conn} do
      conn =
        post(conn, Routes.canvas_path(conn, :write_canvas), %{
          "flood_fill" => %{
            "id" => 1,
            "x" => 0,
            "y" => 0,
            "fill_char" => "XXXX"
          }
        })

      res = json_response(conn, 412)

      assert res == %{
               "data" => %{
                 "error" =>
                   "Fill should always be present or should always have byte_size lenght of 1 in flood_fill drawings"
               }
             }
    end
  end
end
