defmodule Mymoney.Accounts.Transaction do
  use Ecto.Schema
  import Ecto.Changeset

  schema "transactions" do
    field :type, :string
    field :value, :decimal
    field :date, :utc_datetime
    field :description, :string


    belongs_to :user, Mymoney.Accounts.User

    many_to_many :tags, Mymoney.Accounts.Tag, join_through: "transactions_tags"

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(transaction, attrs) do
    transaction
    |> cast(attrs, [:description, :value, :type, :date, :user_id])
    |> validate_required([:description, :value, :type, :date, :user_id])
    |> validate_inclusion(:type, ["RECEITA", "DESPESA"])
    |> foreign_key_constraint(:user_id)
  end
end
