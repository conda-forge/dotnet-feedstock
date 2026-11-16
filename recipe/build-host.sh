#!/bin/bash
set -eox pipefail

# dotnet-host: the files every installed .NET major shares -- the `dotnet`
# muxer at the root of DOTNET_ROOT and the environment activation scripts.
# Everything else in the tarball lives in version-named subdirectories
# (shared/*/<ver>/, host/fxr/<ver>/, sdk/<ver>/, packs/*/<ver>/, ...), which
# is what lets dotnet-runtime-10 and dotnet-runtime-11 share one DOTNET_ROOT.
# conda-forge/dotnet-feedstock#131.

PREFIX=$(echo "${PREFIX}" | tr '\\' '/')

if [[ "${target_platform}" == win-* ]]; then
    DOTNET_ROOT="${PREFIX}/dotnet"
else
    DOTNET_ROOT="${PREFIX}/lib/dotnet"
fi

mkdir -p "${DOTNET_ROOT}/tools"

cp ./dotnet/dotnet* "${DOTNET_ROOT}"

mkdir -p "${PREFIX}/etc/conda/activate.d"
mkdir -p "${PREFIX}/etc/conda/deactivate.d"
cp -r "${RECIPE_DIR}/activate.d/." "${PREFIX}/etc/conda/activate.d/"
cp -r "${RECIPE_DIR}/deactivate.d/." "${PREFIX}/etc/conda/deactivate.d/"

if [[ "${target_platform}" == osx-* ]]; then
    source "${RECIPE_DIR}/osx-resign.sh"
fi
