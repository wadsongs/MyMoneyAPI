defmodule MymoneyWeb.TransactionController do
  use MymoneyWeb, :controller

  alias Mymoney.Accounts
  alias Mymoney.Accounts.Transaction

  action_fallback MymoneyWeb.FallbackController

  def index(conn, _params) do
    transactions = Accounts.list_transactions()
    render(conn, :index, transactions: transactions)
  end

  def create(conn, %{"transaction" => transaction_params}) do
    with {:ok, %Transaction{} = transaction} <- Accounts.create_transaction(transaction_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/transactions/#{transaction}")
      |> render(:show, transaction: transaction)
    end
  end

  def show(conn, %{"id" => id}) do
    transaction = Accounts.get_transaction!(id)
    render(conn, :show, transaction: transaction)
  end

  def update(conn, %{"id" => id, "transaction" => transaction_params}) do
    transaction = Accounts.get_transaction!(id)

    with {:ok, %Transaction{} = transaction} <- Accounts.update_transaction(transaction, transaction_params) do
      render(conn, :show, transaction: transaction)
    end
  end

  def delete(conn, %{"id" => id}) do
    transaction = Accounts.get_transaction!(id)

    with {:ok, %Transaction{}} <- Accounts.delete_transaction(transaction) do
      send_resp(conn, :no_content, "")
    end
  end
end
