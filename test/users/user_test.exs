defmodule Exlivery.Users.UserTest do
  use ExUnit.Case

  alias Exlivery.Users.User

  import Exlivery.Factory

  describe "build/5" do
    test "when all params are valid, return :ok with the user struct" do
      output =
        User.build(
          "esquilo",
          "esquilo@domain.com",
          "12345678909",
          27,
          "rua das arvores"
        )

      expected = {:ok, build(:user)}

      assert output == expected
    end

    test "when invalid input, return :error" do
      output = User.build("fulano", "fulano@domain.com", "12345678909", 17, "rua de cima")

      expected = {:error, "invalid parameters"}

      assert output == expected
    end
  end
end
