defmodule Mymoney.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Mymoney.Accounts` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: "some email",
        name: "some name",
        password: "some password"
      })
      |> Mymoney.Accounts.create_user()

    user
  end

  @doc """
  Generate a transaction.
  """
  def transaction_fixture(attrs \\ %{}) do
    {:ok, transaction} =
      attrs
      |> Enum.into(%{
        date: ~U[2025-06-14 08:31:00Z],
        description: "some description",
        type: "some type",
        value: "120.5"
      })
      |> Mymoney.Accounts.create_transaction()

    transaction
  end

  @doc """
  Generate a tag.
  """
  def tag_fixture(attrs \\ %{}) do
    {:ok, tag} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Mymoney.Accounts.create_tag()

    tag
  end
end
