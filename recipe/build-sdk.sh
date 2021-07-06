#!/bin/bash
set -eox pipefail

LD_LIBRARY_PATH="/usr/local/lib" # https://github.com/dotnet/core/blob/main/Documentation/build-and-install-rhel6-prerequisites.md#troubleshooting
PREFIX=$(echo "${PREFIX}" | tr '\\' '/')

if [[ "${target_platform}" == "win-64" ]]; then
    DOTNET_ROOT="${PREFIX}/dotnet"
else
    DOTNET_ROOT="${PREFIX}/lib/dotnet"
fi

mkdir -p "${DOTNET_ROOT}"
cp -r ./dotnet/packs/ "${DOTNET_ROOT}/packs/"
cp -r ./dotnet/sdk/ "${DOTNET_ROOT}/sdk/"
cp -r ./dotnet/templates/ "${DOTNET_ROOT}/templates/"
