defmodule MeetupWeb.PageController do
  use MeetupWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
