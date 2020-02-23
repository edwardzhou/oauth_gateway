defmodule OauthGateway.Factories.AuthenticationFactory do
  defmacro __using__(_opts) do
    quote do
      alias OauthGateway.Accounts.Authentication

      def authentication_factory() do
        %Authentication{
          nickname: sequence(:nickname, &"nickname_#{&1}"),
          email: sequence(:email, &"user_#{&1}@non_exist.xx"),
          uid: sequence(:uid, &"#{&1 + 1000}"),
          name: sequence(:name, &"name_#{&1}"),
          provider: "console",
          phone:
            sequence(
              :phone,
              &~s(199#{&1 |> Integer.to_string() |> String.pad_leading(8, "0")})
            ),
          image: "https://upload.jianshu.io/users/upload_avatars/4753959/89a67f5a-ad18-45e4-b19e-dc34e502d658.png?imageMogr2/auto-orient/strip|imageView2/1/w/240/h/240",
          token: "token_abc",
          refresh_token: "refresh_token_abc"
        }
      end
    end
  end
end
