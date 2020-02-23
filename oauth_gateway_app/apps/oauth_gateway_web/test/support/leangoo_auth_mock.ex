defmodule OauthGatewayWeb.LeangooAuthMock do

  def user_auth(_params) do
    {:ok,
    %Tesla.Env{
      __client__: %Tesla.Client{adapter: nil, fun: nil, post: [], pre: []},
      __module__: OauthGatewayWeb.LeangooAuth,
      body: %{"code" => 0, "url" => "https://www.leangoo.com/"},
      headers: [
        {"cache-control", "max-age=0, private, must-revalidate"},
        {"date", "Sun, 23 Feb 2020 13:12:13 GMT"},
        {"server", "Cowboy"},
        {"content-length", "19"},
        {"content-type", "application/json; charset=utf-8"},
        {"access-control-allow-credentials", "true"},
        {"access-control-allow-origin", "*"},
        {"access-control-expose-headers", ""},
        {"cross-origin-window-policy", "deny"},
        {"x-content-type-options", "nosniff"},
        {"x-download-options", "noopen"},
        {"x-frame-options", "SAMEORIGIN"},
        {"x-permitted-cross-domain-policies", "none"},
        {"x-request-id", "FfYKM0Y0EBgTIe4AAA2l"},
        {"x-xss-protection", "1; mode=block"}
      ],
      method: :post,
      opts: [],
      query: [],
      status: 200,
      url: "http://localhost:4100/user_auth"
    }}
  end

end
