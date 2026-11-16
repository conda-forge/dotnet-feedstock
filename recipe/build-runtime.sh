#!/bin/bash
set -eox pipefail

PREFIX=$(echo "${PREFIX}" | tr '\\' '/')

if [[ "${target_platform}" == win-* ]]; then
    DOTNET_ROOT="${PREFIX}/dotnet"
else
    DOTNET_ROOT="${PREFIX}/lib/dotnet"
fi

# The muxer and activation scripts are in dotnet-host (build-host.sh). host/
# holds only host/fxr/<ver>/, which is version-named and so stays here: each
# major ships its own hostfxr and the muxer picks the newest present.
mkdir -p "${DOTNET_ROOT}/shared"

cp -r ./dotnet/shared/Microsoft.NETCore.App/ "${DOTNET_ROOT}/shared/Microsoft.NETCore.App/"
cp -r ./dotnet/host/ "${DOTNET_ROOT}/host/"

runtime_lib_dir=${DOTNET_ROOT}/shared/Microsoft.NETCore.App/${DOTNET_RUNTIME_VERSION}
if [[ "${target_platform}" == "linux-"* ]]; then
    # Hack to fix liblttng-ust dependency issues. liblttng-ust.so.0 is no longer supported.
    patchelf --remove-needed liblttng-ust.so.0 ${runtime_lib_dir}/libcoreclrtraceptprovider.so
fi

if [[ "${target_platform}" == osx-* ]]; then
    source "${RECIPE_DIR}/osx-resign.sh"
fi
