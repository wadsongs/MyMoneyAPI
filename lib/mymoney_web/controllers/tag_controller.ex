defmodule MymoneyWeb.TagController do
  use MymoneyWeb, :controller

  alias Mymoney.Accounts
  alias Mymoney.Accounts.Tag

  action_fallback MymoneyWeb.FallbackController

  def index(conn, _params) do
    tags = Accounts.list_tags()
    render(conn, :index, tags: tags)
  end

  def create(conn, %{"tag" => tag_params}) do
    with {:ok, %Tag{} = tag} <- Accounts.create_tag(tag_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/tags/#{tag}")
      |> render(:show, tag: tag)
    end
  end

  def show(conn, %{"id" => id}) do
    tag = Accounts.get_tag!(id)
    render(conn, :show, tag: tag)
  end

  def update(conn, %{"id" => id, "tag" => tag_params}) do
    tag = Accounts.get_tag!(id)

    with {:ok, %Tag{} = tag} <- Accounts.update_tag(tag, tag_params) do
      render(conn, :show, tag: tag)
    end
  end

  def delete(conn, %{"id" => id}) do
    tag = Accounts.get_tag!(id)

    with {:ok, %Tag{}} <- Accounts.delete_tag(tag) do
      send_resp(conn, :no_content, "")
    end
  end
end
