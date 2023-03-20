defmodule Exlivery.Users.AgentTest do
  use ExUnit.Case
  alias Exlivery.Users.Agent, as: UserAgent
  alias Exlivery.Users.User

  import Exlivery.Factory

  describe "save/1" do
    test "should save the user" do
      user = build(:user)
      UserAgent.start_link(%{})
      assert UserAgent.save(user) == :ok
    end
  end

  describe "get/1" do
    setup do
      UserAgent.start_link(%{})
      {:ok, cpf: "12345678909"}
    end

    test "should return the user when found", %{cpf: cpf} do
      :user
      |> build(cpf: cpf)
      |> UserAgent.save()

      output = UserAgent.get(cpf)

      expected =
        {:ok,
         %Exlivery.Users.User{
           name: "esquilo",
           email: "esquilo@domain.com",
           cpf: cpf,
           age: 27,
           address: "rua das arvores"
         }}

      assert output == expected
    end

    test "should return error when user not found" do
      output = UserAgent.get("00000000000")
      expected = {:error, "User not found"}
      assert output == expected
    end
  end
end
