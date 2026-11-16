#!/bin/bash
set -eox pipefail

PREFIX=$(echo "${PREFIX}" | tr '\\' '/')

if [[ "${target_platform}" == win-* ]]; then
    DOTNET_ROOT="${PREFIX}/dotnet"
else
    DOTNET_ROOT="${PREFIX}/lib/dotnet"
fi

mkdir -p "${DOTNET_ROOT}/shared"
cp -r ./dotnet/shared/Microsoft.AspNetCore.App/ "${DOTNET_ROOT}/shared/Microsoft.AspNetCore.App/"

if [[ "${target_platform}" == osx-* ]]; then
    source "${RECIPE_DIR}/osx-resign.sh"
fi
