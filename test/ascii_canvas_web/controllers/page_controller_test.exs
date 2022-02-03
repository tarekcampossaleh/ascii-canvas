defmodule AsciiCanvasWeb.PageControllerTest do
  use AsciiCanvasWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Welcome ASCII canvas read-only client"
  end
end
