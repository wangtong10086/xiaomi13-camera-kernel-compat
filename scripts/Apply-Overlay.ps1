[CmdletBinding()]
param(
    [Parameter(Mandatory)][string]$ModulesRepo,
    [string]$ExpectedCommit = 'f5956ffd9766dcdae24a9f5c6a0c7512bb6b5f5a'
)

$ErrorActionPreference = 'Stop'
$repo = [IO.Path]::GetFullPath($ModulesRepo).TrimEnd('\')
if (-not (Test-Path -LiteralPath (Join-Path $repo '.git'))) { throw "Not a Git checkout: $repo" }

$head = (& git -C $repo rev-parse HEAD).Trim()
if ($LASTEXITCODE -ne 0 -or $head -ne $ExpectedCommit) {
    throw "Modules commit mismatch. Expected $ExpectedCommit, got $head"
}
$dirty = @(& git -C $repo status --porcelain)
if ($LASTEXITCODE -ne 0) { throw 'Unable to inspect modules checkout.' }
if ($dirty.Count) { throw 'Modules checkout must be clean before applying the overlay.' }

$overlay = [IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..\overlay')).TrimEnd('\')
$files = @(Get-ChildItem -LiteralPath $overlay -Recurse -File | Sort-Object FullName)
foreach ($file in $files) {
    $relative = $file.FullName.Substring($overlay.Length + 1)
    $destination = [IO.Path]::GetFullPath((Join-Path $repo $relative))
    if (-not $destination.StartsWith($repo + '\', [StringComparison]::OrdinalIgnoreCase)) {
        throw "Overlay path escapes checkout: $relative"
    }
    $parent = [IO.Path]::GetDirectoryName($destination)
    [IO.Directory]::CreateDirectory($parent) | Out-Null
    Copy-Item -LiteralPath $file.FullName -Destination $destination -Force
}

[pscustomobject]@{ ModulesRepo = $repo; BaseCommit = $head; OverlayFiles = $files.Count; Applied = $true }
