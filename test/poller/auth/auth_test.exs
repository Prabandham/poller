defmodule Poller.Auth.AuthTest do
  use ExUnit.Case, async: true

  test "Should Hash the users raw password" do
    changeset =
      %Poller.Auth.User{}
      |> Poller.Auth.User.new_changeset(%{
        username: "Srinidhi",
        email: "sriprabandham@gmail.com",
        password: "password"
      })

    assert changeset.changes.hash_password != nil
  end

  test "Should generate a vefication code when user is new" do
    changeset =
      %Poller.Auth.User{}
      |> Poller.Auth.User.new_changeset(%{
        username: "Srinidhi",
        email: "sriprabandham@gmail.com",
        password: "password"
      })

    assert changeset.changes.verification_code != nil
  end

  test "should validate length of password to be a minimum of 8" do
    changeset =
      %Poller.Auth.User{}
      |> Poller.Auth.User.new_changeset(%{
        username: "Srinidhi",
        email: "sriprabandham@gmail.com",
        password: "test"
      })

    assert changeset.valid? == false
  end
end
