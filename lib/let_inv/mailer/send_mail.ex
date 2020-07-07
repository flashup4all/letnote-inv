defmodule LetInv.Mailer.SendMail do

    import Swoosh.Email
    alias LetInv.Mailer

    def send_transaction_mail(%{user: user, subject: subject, text: text, html: html, transaction: transaction}) do
        IO.inspect user
        new()
        |> to({user.name, user.email})
        |> from({"credit", "txn@letinc.com"})
        |> subject("#{transaction.type} - #{convert_to_binary(transaction.amount)}")
        |> html_body(html)
        |> text_body("Hello dr\n")
        |> Mailer.deliver
    end

    def convert_to_binary(dec), do: dec |> :erlang.float_to_binary([ :compact, decimals: 2])
end