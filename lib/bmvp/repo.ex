defmodule Bmvp.Repo do
  use Ecto.Repo,
    otp_app: :bmvp,
    adapter: Ecto.Adapters.Postgres

  @spec to_tagged_tuple(any) :: {:error, :not_found} | {:ok, any}
  def to_tagged_tuple(nil), do: {:error, :not_found}
  def to_tagged_tuple(record), do: {:ok, record}
end
