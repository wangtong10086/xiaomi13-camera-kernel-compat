[CmdletBinding()]
param(
    [Parameter(Mandatory)][string]$CameraModule,
    [Parameter(Mandatory)][string]$VendorDlkmImage
)

$ErrorActionPreference = 'Stop'
$expected = @{
    Camera = @{ Length = 6484456L; Hash = '048DBADCCA5C65823DE5A9FA879CABB20DE4E3B90B6C8B8126F488B40BE5725B' }
    Image = @{ Length = 33181696L; Hash = 'FACBD5629E47F0053954E7B47E3E5231069B2F40D8BAE52C9F2CBE6DB63242C0' }
}

function Test-One([string]$Path, [hashtable]$Expectation) {
    $file = Get-Item -LiteralPath $Path -ErrorAction Stop
    $hash = (Get-FileHash -LiteralPath $file.FullName -Algorithm SHA256).Hash
    if ($file.Length -ne $Expectation.Length) { throw "Length mismatch: $($file.FullName)" }
    if ($hash -ne $Expectation.Hash) { throw "SHA-256 mismatch: $($file.FullName)" }
    [pscustomobject]@{ Path = $file.FullName; Length = $file.Length; SHA256 = $hash; Verified = $true }
}

Test-One -Path $CameraModule -Expectation $expected.Camera
Test-One -Path $VendorDlkmImage -Expectation $expected.Image
