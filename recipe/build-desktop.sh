#!/bin/bash
set -eox pipefail

PREFIX=$(echo "${PREFIX}" | tr '\\' '/')

if [[ "${target_platform}" == "win-64" ]]; then
    DOTNET_ROOT="${PREFIX}/dotnet"
else
    DOTNET_ROOT="${PREFIX}/lib/dotnet"
fi

mkdir -p "${DOTNET_ROOT}/shared"
cp -r ./dotnet/shared/Microsoft.WindowsDesktop.App/ "${DOTNET_ROOT}/shared/Microsoft.WindowsDesktop.App/"
