param(
    [string] $docfxExeUrl = "https://github.com/dotnet/docfx/releases/download/v2.5.4/docfx.zip"
)
$ErrorActionPreference = 'Stop'


$scriptPath = $MyInvocation.MyCommand.Path
$scriptHome = Split-Path $scriptPath
$docs = Join-Path $scriptHome "docs"
$tempFolder = Join-Path $scriptHome "aspnet"
md -Force $tempFolder

Push-Location $scriptHome
Push-Location $tempFolder

$docfxZip = Join-Path $tempFolder "docfx.zip"
$docfx = Join-Path $tempFolder "docfx"

if (-Not (Test-Path $docfx\docfx.exe))
{
    # download docfx from github.com
    Invoke-WebRequest $docfxExeUrl -OutFile $docfxZip

    # unzip docfx.zip
    Add-Type -AssemblyName System.IO.Compression.FileSystem
    function Unzip
    {
        param([string]$zipfile, [string]$outpath)

        [System.IO.Compression.ZipFile]::ExtractToDirectory($zipfile, $outpath)
    }
    Unzip $docfxZip $docfx
}

# run docfx metadata to generate YAML metadata
& $docfx\docfx.exe metadata $docs\docfx.json
if($LASTEXITCODE -ne 0)
{
    Pop-Location
    exit 1
}