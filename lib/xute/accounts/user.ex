defmodule Xute.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :firstname, :string
    field :lastname, :string
    field :password, :string, virtual: true
    field :password_confimation, :string, virtual: true
    field :password_hash, :string
    field :username, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:firstname, :lastname, :username, :email])
    |> validate_required([:firstname, :lastname, :username, :email])
    |> validate_length(:username, min: 3, max: 20)
    |> unique_constraint(:username)
  end

  def registration_changeset(user, attrs) do
    user
    |> changeset(attrs)
    |> cast(attrs, [:password])
    |> validate_required([:password, :email])
    |> validate_length(:password, min: 6, max: 20)
    |> validate_confirmation(:email)
    |> validate_confirmation(:password)
    |> put_password_hash()
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}}
        -> put_change(changeset, :password_hash, Pbkdf2.hash_pwd_salt(pass))
      _ -> changeset
    end
  end
end
