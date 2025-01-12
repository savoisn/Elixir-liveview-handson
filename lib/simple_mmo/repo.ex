defmodule SimpleMmo.Repo do
  use Ecto.Repo,
    otp_app: :simple_mmo,
    adapter: Ecto.Adapters.Postgres
end
