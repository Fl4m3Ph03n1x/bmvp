defmodule BmvpWeb.PageController do
  use BmvpWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
