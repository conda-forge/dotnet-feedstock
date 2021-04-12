$env:_CONDA_BACKUP_DOTNET_ROOT = $env:DOTNET_ROOT
$env:_CONDA_BACKUP_DOTNET_TOOLS = $env:DOTNET_TOOLS

$env:DOTNET_ROOT = Join-Path $env:CONDA_PREFIX dotnet
$env:DOTNET_TOOLS = Join-Path $env:DOTNET_ROOT tools

$env:DOTNET_CLI_TELEMETRY_OPTOUT='true'
$env:DOTNET_SKIP_FIRST_TIME_EXPERIENCE='true'
$env:DOTNET_ADD_GLOBAL_TOOLS_TO_PATH='false'

# remove existing entries to prevent duplicates
$path = @($env:DOTNET_ROOT, ${env:DOTNET_TOOLS})
$path += (
    $env:PATH.Split(';') `
    | Where-Object { $_ -ne $env:DOTNET_ROOT } `
    | Where-Object { $_ -ne $env:DOTNET_TOOLS } `
)
$env:PATH = $path -join ';'
