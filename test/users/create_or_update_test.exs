defmodule Exlivery.Users.CreateOrUpdateTest do
  use ExUnit.Case

  alias Exlivery.Users.Agent, as: UserAgent
  alias Exlivery.Users.CreateOrUpdate

  describe "call/1" do
    setup do
      UserAgent.start_link(%{})
      :ok
    end

    test "should save the user when params are valid" do
      input = %{
        name: "esquilo",
        address: "rua das arvores, 1",
        email: "esquilo@domain.com",
        cpf: "12345678909",
        age: 19
      }

      output = CreateOrUpdate.call(input)
      expected = {:ok, "user successfully upserted"}

      assert output == expected
    end

    test "should return error when receives invalid params" do
      input = %{
        name: "esquilinho jr",
        address: "rua das arvores, 1",
        email: "esquilo@domain.com",
        cpf: "12345678909",
        age: 17
      }

      output = CreateOrUpdate.call(input)
      expected = :error

      assert output == expected
    end
  end
end
