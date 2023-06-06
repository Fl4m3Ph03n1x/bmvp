defmodule BmvpWeb.OverviewLive do
  use BmvpWeb, :live_view

  alias Bmvp.{Accounts, Articles}

  def render(assigns) do
    ~H"""
    <%= if is_nil(@author) do %>
      <!--
    This example requires updating your template:

    ```
    <html class="h-full">
    <body class="h-full">
    ```
    -->
      <main class="grid min-h-full place-items-center bg-white px-6 py-24 sm:py-32 lg:px-8">
        <div class="text-center">
          <p class="text-base font-semibold text-indigo-600">404</p>
          <h1 class="mt-4 text-3xl font-bold tracking-tight text-gray-900 sm:text-5xl">
            Author not found
          </h1>
          <p class="mt-6 text-base leading-7 text-gray-600">
            Sorry, we couldn't find the author your were looking for.
          </p>
          <div class="mt-10 flex items-center justify-center gap-x-6">
            <a
              href="/"
              class="rounded-md bg-indigo-600 px-3.5 py-2.5 text-sm font-semibold text-white shadow-sm hover:bg-indigo-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600"
            >
              Go back home
            </a>
          </div>
        </div>
      </main>
    <% else %>
      <div class="bg-white py-24 sm:py-32">
        <div class="mx-auto max-w-7xl px-6 lg:px-8">
          <div class="mx-auto max-w-2xl lg:mx-0">
            <h2 class="text-3xl font-bold tracking-tight text-gray-900 sm:text-4xl">
              Articles from <%= @author.username %>
            </h2>
          </div>
          <div class="mx-auto mt-10 grid max-w-2xl grid-cols-1 gap-x-8 gap-y-16 border-t border-gray-200 pt-10 sm:mt-16 sm:pt-16 lg:mx-0 lg:max-w-none lg:grid-cols-3">
            <%= for article <- @articles do %>
              <article class="flex max-w-xl flex-col items-start justify-between">
                <div class="flex items-center gap-x-4 text-xs">
                  <time datetime="2020-03-16" class="text-gray-500"><%= article.updated_at %></time>
                </div>
                <div class="group relative">
                  <h3 class="mt-3 text-lg font-semibold leading-6 text-gray-900 group-hover:text-gray-600">
                    <a href="#">
                      <span class="absolute inset-0"></span> <%= article.title %>
                    </a>
                  </h3>
                  <p class="mt-5 line-clamp-3 text-sm leading-6 text-gray-600">
                    <%= String.slice(article.content, 0, 200) %>
                  </p>
                </div>
              </article>
            <% end %>
          </div>
        </div>
      </div>
    <% end %>
    """
  end

  def mount(%{"username" => username}, _session, socket) do
    with {:ok, user} <- Accounts.get_user_by_username(username),
         articles <- Articles.list_articles_by_author_id(user.id) do
      {:ok, assign(socket, author: user, articles: articles)}
    else
      _error ->
        socket =
          socket
          |> assign(author: nil, articles: [])
          |> put_flash(:error, "Author not found!")

        {:ok, socket}
    end
  end
end
