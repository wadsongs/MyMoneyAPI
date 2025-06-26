defmodule Mymoney.Repo do
  use Ecto.Repo,
    otp_app: :mymoney,
    adapter: Ecto.Adapters.Postgres
end
