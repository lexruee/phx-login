# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Xute.Repo.insert!(%Xute.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Xute.Accounts

def user(i) do
  %{
    username: "jdoe#{i}",
    firstname: "Joe#{i}",
    lastname: "Doe#{i}",
    email: "john.doe#{i}@example.com",
    email_confirmation: "john.doe#{i}@example.com",
    password: "123456",
    password_confirmation: "123456",
  }
end

(1..100)
|> Enum.map(&user/1)
|> Enum.each(&Accounts.create_user!/1)
