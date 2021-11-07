#!/bin/sh
export MIX_ENV=$MIX_ENV
export APPSIGNAL_BUILD_FOR_MUSL=1

# Start Phenix
mix phx.server