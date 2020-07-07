defmodule LetInv.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  use Pow.Ecto.Schema
  use Pow.Extension.Ecto.Schema, extensions: [PowResetPassword, PowEmailConfirmation]

  schema "users" do
    pow_user_fields()
    field :is_admin, :boolean, default: false
    field :name, :string
    field :provider, :string, null: false
    field :mobile_no, :string, null: false
    field :role, :integer, default: 1
    timestamps()
  end

  def changeset(user_or_changeset, attrs) do
    user_or_changeset
    |> pow_changeset(attrs)
    |> Ecto.Changeset.cast(attrs, [:mobile_no, :name, :provider, :is_admin, :role])
    |> Ecto.Changeset.validate_required([:mobile_no, :name, :is_admin])
    # Check that email is valid
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 5)
    |> pow_extension_changeset(attrs)
  end
end
