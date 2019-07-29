defmodule Xute.TestHelpers do

  alias Xute.{
    Accounts,
    Accounts.User
    }

  def user_map_fixture(attrs \\ %{}) do
    Enum.into(attrs, %{
      firstname: attrs[:firstname] || "John",
      lastname: attrs[:lastname] || "Doe",
      email: attrs[:email] || "john.doe@example.com",
      email_confirmation: attrs[:email] || "john.doe@example.com",
      username: attrs[:username] || "jdoe",
      password: attrs[:password] || "123456",
      password_confirmation: attrs[:password] || "123456",
    })
  end

  def user_fixture(attrs \\ %{}) do
    {:ok, user} = user_map_fixture(attrs)
                  |> Accounts.register_user()
    user
  end
end