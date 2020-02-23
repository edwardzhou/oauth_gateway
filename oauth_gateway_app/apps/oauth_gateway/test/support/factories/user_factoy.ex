defmodule OauthGateway.Factories.UserFactory do
  defmacro __using__(_opts) do
    quote do
      alias OauthGateway.Accounts.User

      def user_factory() do
        %User{
          nickname: sequence(:nickname, &"nickname_#{&1}"),
          username: sequence(:login_name, &"user_#{&1}"),
          email: sequence(:email, &"user_#{&1}@non_exist.xx"),
          phone:
            sequence(
              :phone,
              &~s(199#{&1 |> Integer.to_string() |> String.pad_leading(8, "0")})
            ),
          avatar_url: "https://upload.jianshu.io/users/upload_avatars/4753959/89a67f5a-ad18-45e4-b19e-dc34e502d658.png?imageMogr2/auto-orient/strip|imageView2/1/w/240/h/240",
        }
      end
    end
  end
end
