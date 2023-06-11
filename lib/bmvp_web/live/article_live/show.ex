defmodule BmvpWeb.ArticleLive.Show do
  use BmvpWeb, :live_view

  alias Bmvp.Articles
  alias BmvpWeb.UrlHelper
  alias LemonEx

  @store_id "31126"
  @variant_id "86125"

  on_mount({BmvpWeb.UserAuth, :mount_current_user})

  def generate_article_abstract(article) do
    abstract = String.slice(article.content, 0..400)
    "#{abstract}..."
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id} = params, _, socket) do
    article = Articles.get_article!(id)
    current_user = socket.assigns.current_user
    show_full_article = can_see_full_article?(current_user, params, article)

    {:noreply,
     socket
     |> assign(:show_full_article, show_full_article)
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:article, article)}
  end

  @impl true
  def handle_event("purchase", _params, socket) do
    article = socket.assigns.article
    price = Articles.get_price_in_cents(article)

    data = %{
      custom_price: price,
      product_options: %{
        name: "Article from CashBlog.org",
        description: article.title
      },
      checkout_data: %{
        custom: %{
          article_id: article.id
        }
      }
    }

    {:ok, checkout} = LemonEx.Checkouts.create(@store_id, @variant_id, data)

    {:noreply, redirect(socket, external: checkout.url)}
  end

  defp page_title(:show), do: "Show Article"
  defp page_title(:edit), do: "Edit Article"

  defp can_see_full_article?(current_user, params, article),
    do: Articles.is_author?(current_user, article) or has_valid_token?(params, article)

  defp has_valid_token?(%{"token" => token}, article) do
    case UrlHelper.verify_unique_article_token(token) do
      {:ok, article_id} -> article_id == article.id
      _error -> false
    end
  end

  defp has_valid_token?(_params, _article), do: false
end
