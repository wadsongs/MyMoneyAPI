defmodule Mymoney.Repo.Migrations.CreateTransactionsTagsJoinTable do
  use Ecto.Migration

  def change do
    create table(:transactions_tags, primary_key: false) do
      add :transaction_id, references(:transactions, on_delete: :delete_all), null: false
      add :tag_id, references(:tags, on_delete: :delete_all), null: false
    end

    create index(:transactions_tags, [:transaction_id])
    create index(:transactions_tags, [:tag_id])
  end
end
