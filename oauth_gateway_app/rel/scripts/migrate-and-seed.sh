#!/bin/sh

echo "Starting migration of oauth_gateway"
$RELEASE_ROOT_DIR/bin/oauth_gateway command Elixir.OauthGateway.Release.Tasks migrate
echo "Finished migration of oauth_gateway"

echo "Starting seeds of oauth_gateway"
$RELEASE_ROOT_DIR/bin/oauth_gateway command Elixir.OauthGateway.Release.Tasks seed
echo "Finished seeds of oauth_gateway"
