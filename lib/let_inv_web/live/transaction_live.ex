defmodule LetInvWeb.TransactionLive do
  # use Phoenix.LiveView, layout: {LetInvWeb.LayoutView, "auth.html"}
  use LetInvWeb, :live_view

  import Swoosh.Email
  alias LetInv.Mailer.SendMail
  @impl true
  def mount(_params, _session, socket) do

    # new()
    # |> to({"Ahead", "flashup4all@gmail.com"})
    # |> from({"Letnote Investments", "hulk.smash@example.com"})
    # |> subject("Hello, how are you!")
    # |> html_body("<h1>Hello Bardeson Lucky</h1>")
    # |> text_body("Hello dr\n")
    # |> Mailer.deliver
    user = %{ email: "flashup4all@gmail.com", name: "John Doe"}
    transaction = %{ type: "debit", amount: 1000.00, id: 2}
    # SendMail.send_transaction_mail(%{user: user, subject: "Testing mail", text: "Hello worls", html: "<h1>Hello John Doe</h1>" , transaction: transaction})
    {:ok, assign(socket, query: "", results: %{}, mode: 1)}
  end

  @impl true
  def handle_event("suggest", %{"q" => query}, socket) do
    {:noreply, assign(socket, results: search(query), query: query)}
  end

  @impl true
  def handle_event("search", %{"q" => query}, socket) do
    case search(query) do
      %{^query => vsn} ->
        {:noreply, redirect(socket, external: "https://hexdocs.pm/#{query}/#{vsn}")}

      _ ->
        {:noreply,
         socket
         |> put_flash(:error, "No dependencies found matching \"#{query}\"")
         |> assign(results: %{}, query: query)}
    end
  end

  defp search(query) do
    if not LetInvWeb.Endpoint.config(:code_reloader) do
      raise "action disabled when not in development"
    end

    for {app, desc, vsn} <- Application.started_applications(),
        app = to_string(app),
        String.starts_with?(app, query) and not List.starts_with?(desc, ~c"ERTS"),
        into: %{},
        do: {app, vsn}
  end
end
