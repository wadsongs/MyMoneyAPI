# lib/sua_app_web/controllers/session_controller.ex
defmodule MymoneyWeb.SessionController do
  use MymoneyWeb, :controller
  alias Mymoney.Accounts
  alias MymoneyWeb.Guardian

  action_fallback MymoneyWeb.FallbackController

  def create(conn, %{"email" => email, "password" => password}) do
    with {:ok, user} <- Accounts.authenticate_user(email, password),
        {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      conn
      |> put_status(:ok)
      |> render("show.json", %{token: token})
    else
      {:error, :unauthorized} ->
        body = %{error: "Invalid email or password"}
        conn |> put_status(:unauthorized) |> json(body)
    end
  end
end
