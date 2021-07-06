#!/bin/bash
set -eox pipefail

PREFIX=$(echo "${PREFIX}" | tr '\\' '/')

if [[ "${target_platform}" == "win-64" ]]; then
    DOTNET_ROOT="${PREFIX}/dotnet"
else
    DOTNET_ROOT="${PREFIX}/lib/dotnet"
    LD_LIBRARY_PATH="${PREFIX}/lib" # https://github.com/dotnet/core/blob/main/Documentation/build-and-install-rhel6-prerequisites.md#troubleshooting
fi

mkdir -p "${DOTNET_ROOT}"
cp -r ./dotnet/packs/ "${DOTNET_ROOT}/packs/"
cp -r ./dotnet/sdk/ "${DOTNET_ROOT}/sdk/"
cp -r ./dotnet/templates/ "${DOTNET_ROOT}/templates/"
