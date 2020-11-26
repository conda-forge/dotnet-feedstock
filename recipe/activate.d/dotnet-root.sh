function remove_from_path {
    # https://unix.stackexchange.com/a/291611
    if [[ -n "$2" ]]; then
        local RESULT=$2
    else
        local RESULT=$PATH
    fi
    RESULT=${RESULT//":$1:"/":"} # delete any instances in the middle
    RESULT=${RESULT/#"$1:"/}     # delete any instance at the beginning
    RESULT=${RESULT/%":$1"/}     # delete any instance in the at the end
    echo "$RESULT"
}

export _CONDA_BACKUP_DOTNET_ROOT=$DOTNET_ROOT
export _CONDA_BACKUP_DOTNET_TOOLS=$DOTNET_TOOLS

export DOTNET_ROOT=$CONDA_PREFIX/lib/dotnet
export DOTNET_TOOLS=$DOTNET_ROOT/tools

export DOTNET_TRY_CLI_TELEMETRY_OPTOUT=true
export DOTNET_TRY_SKIP_FIRST_TIME_EXPERIENCE=true
export DOTNET_ADD_GLOBAL_TOOLS_TO_PATH=false

# remove existing entries to prevent duplicates
NEW_PATH=$(remove_from_path "${DOTNET_ROOT}")
NEW_PATH=$(remove_from_path "${DOTNET_TOOLS}" "${NEW_PATH}")

export PATH="${DOTNET_ROOT}:${DOTNET_TOOLS}:${NEW_PATH}"
