#!/bin/sh
set -e

# mix ecto.create
# mix ecto.migrate
mix do ecto.create, ecto.migrate, phx.server
