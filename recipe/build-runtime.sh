#!/bin/bash
set -eox pipefail

PREFIX=$(echo "${PREFIX}" | tr '\\' '/')

if [[ "${target_platform}" == "win-64" ]]; then
    DOTNET_ROOT="${PREFIX}/dotnet"
else
    DOTNET_ROOT="${PREFIX}/lib/dotnet"
fi

mkdir -p "${DOTNET_ROOT}/shared"
mkdir -p "${DOTNET_ROOT}/tools"

cp ./dotnet/dotnet* "${DOTNET_ROOT}"
cp -r ./dotnet/shared/Microsoft.NETCore.App/ "${DOTNET_ROOT}/shared/Microsoft.NETCore.App/"
cp -r ./dotnet/host/ "${DOTNET_ROOT}/host/"

mkdir -p "${PREFIX}/etc/conda/activate.d"
mkdir -p "${PREFIX}/etc/conda/deactivate.d"
cp -r "${RECIPE_DIR}/activate.d/." "${PREFIX}/etc/conda/activate.d/"
cp -r "${RECIPE_DIR}/deactivate.d/." "${PREFIX}/etc/conda/deactivate.d/"
