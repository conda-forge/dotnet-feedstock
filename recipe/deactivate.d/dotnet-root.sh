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

NEW_PATH=$(remove_from_path "${DOTNET_ROOT}")
NEW_PATH=$(remove_from_path "${DOTNET_TOOLS}" "${NEW_PATH}")
export PATH=$NEW_PATH

unset DOTNET_CLI_TELEMETRY_OPTOUT
unset DOTNET_SKIP_FIRST_TIME_EXPERIENCE
unset DOTNET_ADD_GLOBAL_TOOLS_TO_PATH
unset DOTNET_MULTILEVEL_LOOKUP
unset DOTNET_NOLOGO

export DOTNET_ROOT=${_CONDA_BACKUP_DOTNET_ROOT}
export DOTNET_TOOLS=${_CONDA_BACKUP_DOTNET_TOOLS}
