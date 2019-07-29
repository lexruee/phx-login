defmodule Xute.AccountsTest do
  use Xute.DataCase, async: true

  alias Xute.Accounts
  alias Xute.Accounts.User

  describe "register_user/1" do
    @valid_attrs %{
      firstname: "John",
      lastname: "Doe",
      email: "john.doe@example.com",
      email_confirmation: "john.doe@example.com",
      username: "jdoe",
      password: "123456",
      password_confirmation: "123456",
    }

    @invalid_attrs %{}

    test "with valid data inserts user" do
      assert {:ok, %User{id: id} = user} = Accounts.register_user(@valid_attrs)
      assert user.firstname == "John"
      assert user.lastname == "Doe"
      assert user.email == "john.doe@example.com"
      assert [%User{id: ^id}] = Accounts.list_users()
    end

    test "with invalid data returns changeset with errors" do
      assert {:error, %Ecto.Changeset{} = changeset} = Accounts.register_user(@invalid_attrs)
      assert %{email: ["can't be blank"], firstname: ["can't be blank"], lastname: ["can't be blank"], password: ["can't be blank"], username: ["can't be blank"]} = errors_on(changeset)
    end

    test "enforces unique usernames" do
      assert {:ok, %User{id: id} = user} = Accounts.register_user(@valid_attrs)
      assert {:error, %Ecto.Changeset{} = changeset} = Accounts.register_user(@valid_attrs)
      assert %{username: ["has already been taken"]} = errors_on(changeset)
    end

    test "does not accept long usernames" do
      attrs = Map.put(@valid_attrs, :username, String.duplicate("a", 30))
      {:error, changeset} = Accounts.register_user(attrs)

      assert %{username: ["should be at most 20 character(s)"]} = errors_on(changeset)
      assert Accounts.list_users() == []
    end

    test "requires password to be at least 6 chars long" do
      attrs = %{@valid_attrs | password: "12345", password_confirmation: "12345"}
      {:error, changeset} = Accounts.register_user(attrs)

      assert %{password: ["should be at least 6 character(s)"]} = errors_on(changeset)
      assert Accounts.list_users() == []
    end
  end

  describe "authenticate_by_username_and_password" do
    @pass "123456"

    setup do
      {:ok, user: user_fixture(password: @pass)}
    end

    test "with valid username and password", %{user: %User{username: username, password: password}} do
      assert {:ok, auth_user} = Accounts.authenticate_by_username_and_password(username, password)
    end

    test "with invalid username", %{user: %User{username: _username, password: password}} do
      assert {:error, :not_found} = Accounts.authenticate_by_username_and_password("foo", password)
    end

    test "with invalid password", %{user: %User{username: username, password: _password}} do
      assert {:error, :unauthorized} = Accounts.authenticate_by_username_and_password(username, "foo")
    end
  end
end