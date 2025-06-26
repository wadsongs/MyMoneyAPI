defmodule Mymoney.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :name, :string
    field :password_hash, :string
    field :email, :string

    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    has_many :transactions, Mymoney.Accounts.Transaction
    has_many :tags, Mymoney.Accounts.Tag

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :password, :password_confirmation])
    |> validate_required([:name, :email])
    |> validate_format(:email, ~r/^[^\s]+@[^\s]+$/, message: "must have the @ sign and no spaces")
    |> validate_length(:password, min: 6, max: 100)
    |> validate_confirmation(:password)
    |> unique_constraint(:email)
    |> put_password_hash()
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        # Se a senha mudou e é válida, cria o hash
        put_change(changeset, :password_hash, Bcrypt.hash_pwd_salt(password))
      _  ->
        # Se não, retorna o changeset como está
        changeset
    end
  end
end
