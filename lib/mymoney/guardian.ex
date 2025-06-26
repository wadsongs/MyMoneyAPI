defmodule MymoneyWeb.Guardian do
  use Guardian, otp_app: :mymoney

  alias Mymoney.Accounts

  # Função que define o que vai no "subject" (sub) do token
  def subject_for_token(user, _claims) do
    # O "sub" será "User:" seguido do ID, ex: "User:1"
    sub = to_string(user.id)
    {:ok, sub}
  end

  # Função que busca o usuário no banco de dados a partir do "sub" do token
  def resource_from_claims(%{"sub" => id}) do
    case Accounts.get_user!(id) do
      nil -> {:error, :resource_not_found}
      user -> {:ok, user}
    end
  end
  def resource_from_claims(_claims), do: {:error, :resource_not_found}
end
