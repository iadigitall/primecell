$filePath = "c:\Users\User\Desktop\prime cell\index.html"
$lines = Get-Content $filePath -Raw
$linesArray = $lines -split "`r`n|`n"

$styleStart = -1
$styleEnd = -1
$scriptStart = -1
$scriptEnd = -1

for ($i=0; $i -lt $linesArray.Length; $i++) {
    if ($linesArray[$i] -match "<style>") { if ($styleStart -eq -1) { $styleStart = $i } }
    if ($linesArray[$i] -match "</style>") { if ($styleEnd -eq -1) { $styleEnd = $i } }
    if ($linesArray[$i] -match "<script>") { if ($scriptStart -eq -1) { $scriptStart = $i } }
    if ($linesArray[$i] -match "</script>") { if ($scriptEnd -eq -1) { $scriptEnd = $i } }
}

$newLines = @()
for ($i=0; $i -lt $linesArray.Length; $i++) {
    if ($i -eq $styleStart) {
        $newLines += '  <link rel="stylesheet" href="style.css" />'
    }
    elseif ($i -gt $styleStart -and $i -le $styleEnd) {
        continue
    }
    elseif ($i -eq $scriptStart) {
        $newLines += '  <script src="script.js" defer></script>'
    }
    elseif ($i -gt $scriptStart -and $i -le $scriptEnd) {
        continue
    }
    else {
        $newLines += $linesArray[$i]
    }
}

$tempPath = "c:\Users\User\Desktop\prime cell\index_temp.html"
$newLines -join "`r`n" | Set-Content $tempPath -Encoding UTF8

If (Test-Path $tempPath) {
    Copy-Item $tempPath $filePath -Force
    Remove-Item $tempPath -Force
    Write-Output "Successfully modified HTML."
}
