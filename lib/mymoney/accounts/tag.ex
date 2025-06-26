defmodule Mymoney.Accounts.Tag do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tags" do
    field :name, :string


    belongs_to :user, Mymoney.Accounts.User

    many_to_many :transactions, Mymoney.Accounts.Transaction, join_through: "transactions_tags"

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(tag, attrs) do
    tag
    |> cast(attrs, [:name, :user_id])
    |> validate_required([:name, :user_id])
    |> foreign_key_constraint(:user_id)
  end
end
