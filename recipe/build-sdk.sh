#!/bin/bash
set -eox pipefail

PREFIX=$(echo "${PREFIX}" | tr '\\' '/')

if [[ "${build_platform}" == "win-64" ]]; then
    DOTNET_ROOT="${PREFIX}/dotnet"
else
    DOTNET_ROOT="${PREFIX}/lib/dotnet"
    cp $RECIPE_DIR/dotnet.bash $PREFIX/bin/dotnet
    chmod +x $PREFIX/bin/dotnet
fi

mkdir -p "${DOTNET_ROOT}"
cp -r ./dotnet/sdk/ "${DOTNET_ROOT}/sdk/"
