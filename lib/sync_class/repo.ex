defmodule SyncClass.Repo do
  use Ecto.Repo,
    otp_app: :sync_class,
    adapter: Ecto.Adapters.Postgres
end
