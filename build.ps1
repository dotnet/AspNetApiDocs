$ErrorActionPreference = 'Stop'

$scriptPath = $MyInvocation.MyCommand.Path
$scriptHome = Split-Path $scriptPath
$docs = Join-Path $scriptHome "docs"
$tempFolder = Join-Path $scriptHome "aspnet"
md -Force $tempFolder

Push-Location $scriptHome
Push-Location $tempFolder

# run docfx metadata to generate YAML metadata
& docfx metadata $docs\docfx.json
if($LASTEXITCODE -ne 0)
{
    Pop-Location
    exit 1
}