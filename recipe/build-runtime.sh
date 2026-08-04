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

runtime_lib_dir=${DOTNET_ROOT}/shared/Microsoft.NETCore.App/${DOTNET_RUNTIME_VERSION}
if [[ "${target_platform}" == "linux-"* ]]; then
    # Hack to fix liblttng-ust dependency issues. liblttng-ust.so.0 is no longer supported.
    patchelf --remove-needed liblttng-ust.so.0 ${runtime_lib_dir}/libcoreclrtraceptprovider.so
fi

mkdir -p "${PREFIX}/etc/conda/activate.d"
mkdir -p "${PREFIX}/etc/conda/deactivate.d"
cp -r "${RECIPE_DIR}/activate.d/." "${PREFIX}/etc/conda/activate.d/"
cp -r "${RECIPE_DIR}/deactivate.d/." "${PREFIX}/etc/conda/deactivate.d/"

# macOS: repair code signatures.
#
# The shipped `dotnet` host and its native libraries carry Microsoft's signature
# with the hardened-runtime flag set. conda-build's post-processing modifies them,
# which invalidates that signature, and macOS SIGKILLs a hardened-runtime binary
# whose signature does not verify -- the `killed dotnet` in
# conda-forge/dotnet-feedstock#111.
#
# Proven by comparing published builds: 8.0.6 (conda-build 25.3.2) verifies and
# runs; 8.0.15 (25.4.2) and 10.0.0 (25.11.0) do not verify and are killed. The
# recipe did not change between them -- conda-build did.
#
# Re-signing ad-hoc replaces the now-invalid signature with a valid one. It
# deliberately does not depend on identifying which post-processing step is
# responsible, so it stays correct if conda-build changes again.
if [[ "${target_platform}" == osx-* ]]; then
    find "${DOTNET_ROOT}" -type f \( -perm -u+x -o -name "*.dylib" \) -print0 \
      | while IFS= read -r -d "" f; do
            if file -b "$f" | grep -q "Mach-O"; then
                codesign --force --sign - "$f" 2>/dev/null || true
            fi
        done
fi
