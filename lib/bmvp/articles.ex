defmodule Bmvp.Articles do
  @moduledoc """
  The Articles context.
  """

  import Ecto.Query, warn: false

  alias Bmvp.Repo
  alias Bmvp.Articles.Article
  alias Money

  @doc """
  Returns the given article's price in cents (EUR).

  ## Examples

      iex> article = %Article{}
      iex> get_price_in_cents(article)
      10000
  """
  def get_price_in_cents(article) do
    {:EUR, cents, -2, _rest} = Money.to_integer_exp(article.price)
    cents
  end

  @doc """
  Returns where or not the given author is the author of the given article.

  ## Examples

      iex> user = %User{}
      iex> article = %Article{}
      iex> is_author(user, article)
      true

  """
  def is_author?(nil, _article), do: false
  def is_author?(user, article), do: user.id == article.author_id

  @doc """
  Returns the list of articles that belong to the given author.

  ## Examples

      iex> user = %User{}
      iex> list_articles_by_author_id(user.id)
      [%Article{}, ...]

  """
  def list_articles_by_author_id(author_id) do
    Article
    |> where([article], article.author_id == ^author_id)
    |> Repo.all()
  end

  @doc """
  Returns the list of articles.

  ## Examples

      iex> list_articles()
      [%Article{}, ...]

  """
  def list_articles do
    Repo.all(Article)
  end

  @doc """
  Gets a single article.

  Raises `Ecto.NoResultsError` if the Article does not exist.

  ## Examples

      iex> get_article!(123)
      %Article{}

      iex> get_article!(456)
      ** (Ecto.NoResultsError)

  """
  def get_article!(id), do: Repo.get!(Article, id)

  @doc """
  Gets a single article.

  Raises `{:error, :not_found}` if the Article does not exist.

  ## Examples

      iex> get_article(123)
      {:ok, %Article{}}

      iex> get_article(456)
      {:error, :not_found}

  """
  def get_article(id), do: Article |> Repo.get(id) |> Repo.to_tagged_tuple()

  @doc """
  Creates a article.

  ## Examples

      iex> create_article(%{field: value})
      {:ok, %Article{}}

      iex> create_article(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_article(attrs \\ %{}) do
    %Article{}
    |> Article.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a article.

  ## Examples

      iex> update_article(article, %{field: new_value})
      {:ok, %Article{}}

      iex> update_article(article, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_article(%Article{} = article, attrs) do
    article
    |> Article.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a article.

  ## Examples

      iex> delete_article(article)
      {:ok, %Article{}}

      iex> delete_article(article)
      {:error, %Ecto.Changeset{}}

  """
  def delete_article(%Article{} = article) do
    Repo.delete(article)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking article changes.

  ## Examples

      iex> change_article(article)
      %Ecto.Changeset{data: %Article{}}

  """
  def change_article(%Article{} = article, attrs \\ %{}) do
    Article.changeset(article, attrs)
  end
end
