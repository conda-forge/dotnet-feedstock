#!/bin/bash
set -eox pipefail

PREFIX=$(echo "${PREFIX}" | tr '\\' '/')

if [[ "${target_platform}" == "win-64" ]]; then
    DOTNET_ROOT="${PREFIX}/dotnet"
else
    DOTNET_ROOT="${PREFIX}/lib/dotnet"
fi

mkdir -p "${DOTNET_ROOT}"
cp -r ./dotnet/packs/ "${DOTNET_ROOT}/packs/"
cp -r ./dotnet/sdk/ "${DOTNET_ROOT}/sdk/"
if [[ -e ./dotnet/sdk-manifests/ ]]; then
    cp -r ./dotnet/sdk-manifests/ "${DOTNET_ROOT}/sdk-manifests/"
fi
cp -r ./dotnet/templates/ "${DOTNET_ROOT}/templates/"

if [[ "${target_platform}" == "linux-aarch64" ]]; then
  patchelf --remove-needed ld-linux-x86-64.so.2 ${DOTNET_ROOT}/sdk/9.0.202/AppHostTemplate/apphost
  for lib in apphost libnethost.so singlefilehost; do
    patchelf --remove-needed ld-linux-x86-64.so.2 ${DOTNET_ROOT}/packs/Microsoft.NETCore.App.Host.linux-x64/${DOTNET_RUNTIME_VERSION}/runtimes/linux-x64/native/$lib
  done
fi
