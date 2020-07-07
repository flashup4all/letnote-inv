defmodule LetInvWeb.AuthLive.Index do
    use LetInvWeb, :live_view

    alias LetInv.Accounts.UserModel

  @impl true
  def mount(_params, _session, socket) do
    socket = assign(socket, 
        form_status: false,
        loading: false,
        page_title: "Letnote Investments - Login",
        auth_form: %{
            email: "root@me.com",
            password: "root123",
        }
    )
    {:ok, socket}
    # {:ok, socket, layout: {LetInvWeb.LayoutView, "auth.html"}}
  end

  def handle_event("login", %{ "email" => email, "password" => password} = args, socket) do
    send(self(), {:authenticate, args})
      socket = assign(socket,
        email: email,
        password: password,
        loading: true
      )
    # #   IO.puts password
    #   IO.puts "ok"
    #   socket = assign(socket, user: %{email: user.email})
      {:noreply, socket |> put_flash(:info, "login successful.. redirecting \"#{ inspect args}") |>redirect(to: "/transaction")}
    # {:noreply, push_redirect(socket, to: "/transaction", replace: true)}

  end

  def handle_info({:authenticate, args}, socket) do
    IO.puts "handle_info start"
    IO.inspect args
    IO.puts "handle_info end"
    socket =
          socket
          |> put_flash(:info, "login successful.. redirecting \"#{ inspect args}\"")
          |> assign(auth_form: %{
                email: "kote@me.com",
                password: "root123",
            }, 
          loading: false)
    {:noreply, socket}
  end

end