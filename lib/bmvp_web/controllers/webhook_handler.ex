defmodule BmvpWeb.WebhookHandler do
  @moduledoc """
  Handles events from Lemonsqueezy's webhooks.
  """

  @behaviour LemonEx.Webhooks.Handler

  alias BmvpWeb.UrlHelper
  alias Bmvp.Accounts.UserNotifier
  alias Bmvp.Articles
  alias LemonEx.Webhooks.Event
  alias BmvpWeb.UrlHelper
  alias UserNotifier

  @impl true
  def handle_event(%Event{name: "order_created"} = event) do
    %{"article_id" => article_id} = event.meta["custom_data"]
    user_email = event.data.user_email

    with {:ok, article} <- Articles.get_article(article_id),
         url <- UrlHelper.gen_unique_article_url(article_id),
         {:ok, _email} <- UserNotifier.deliver_article_url(user_email, url, article) do
      :ok
    end
  end

  @impl true
  def handle_event(_unhandled_event), do: :ok
end
