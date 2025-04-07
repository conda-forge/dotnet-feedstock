# get correct path separator for the current OS
$pathSep = [System.IO.Path]::PathSeparator

$path = (
    $env:PATH.Split($pathSep) `
    | Where-Object { $_ -ne $env:DOTNET_ROOT } `
    | Where-Object { $_ -ne $env:DOTNET_TOOLS } `
)
$env:PATH = $path -join $pathSep

$env:DOTNET_CLI_TELEMETRY_OPTOUT=''
$env:DOTNET_SKIP_FIRST_TIME_EXPERIENCE=''
$env:DOTNET_ADD_GLOBAL_TOOLS_TO_PATH=''
$env:DOTNET_MULTILEVEL_LOOKUP=''
$env:DOTNET_NOLOGO=''

$env:DOTNET_ROOT = $env:_CONDA_BACKUP_DOTNET_ROOT
$env:DOTNET_TOOLS = $env:_CONDA_BACKUP_DOTNET_TOOLS
