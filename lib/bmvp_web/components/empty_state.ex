defmodule BmvpWeb.Component.EmptyState do
  @moduledoc false

  use BmvpWeb, :html

  attr(:text, :string, required: true)
  attr(:image, :string, required: true)

  @spec show(map) :: Phoenix.LiveView.Rendered.t()
  def show(assigns) do
    ~H"""
    <div>
      <h2 class="text-lg font-semibold tracking-tight sm:text-center sm:text-lg">
        <%= @text %>
      </h2>
      <div class="mt-10 mx-auto w-full max-w-xs">
        <img
          scr={~p"/images/#{@image}"}
          alt="Write a blog"
          class="w-full max-w-none rounded-xl ring-1 ring-gray-400/10 md:-ml-4 lg:-ml-0"
          width="2432"
          height="1442"
        />
      </div>
    </div>
    """
  end
end
