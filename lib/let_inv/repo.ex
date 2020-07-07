defmodule LetInv.Repo do
  use Ecto.Repo,
    otp_app: :let_inv,
    adapter: Ecto.Adapters.Postgres
end
