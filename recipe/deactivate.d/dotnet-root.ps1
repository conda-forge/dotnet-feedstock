$path = (
    $env:PATH.Split(';') `
    | Where-Object { $_ -ne $env:DOTNET_ROOT } `
    | Where-Object { $_ -ne $env:DOTNET_TOOLS } `
)
$env:PATH = $path -join ';'

$env:DOTNET_CLI_TELEMETRY_OPTOUT=''
$env:DOTNET_SKIP_FIRST_TIME_EXPERIENCE=''
$env:DOTNET_ADD_GLOBAL_TOOLS_TO_PATH=''

$env:DOTNET_ROOT = $env:_CONDA_BACKUP_DOTNET_ROOT
$env:DOTNET_TOOLS = $env:_CONDA_BACKUP_DOTNET_TOOLS
