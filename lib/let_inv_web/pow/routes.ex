defmodule LetInvWeb.Pow.Routes do

  use Pow.Phoenix.Routes
  alias LetInvWeb.Router.Helpers, as: Routes

  def after_sign_in_path(conn), do: Routes.transaction_path(conn, :index)
end
