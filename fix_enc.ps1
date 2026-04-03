$enc1252 = [System.Text.Encoding]::GetEncoding(1252)
$encUTF8 = [System.Text.Encoding]::UTF8
foreach ($file in @("index.html", "style.css", "script.js")) {
    $path = "c:\Users\User\Desktop\prime cell\$file"
    try {
        $wrongText = [System.IO.File]::ReadAllText($path, $encUTF8)
        $originalBytes = $enc1252.GetBytes($wrongText)
        $fixedText = $encUTF8.GetString($originalBytes)
        [System.IO.File]::WriteAllText($path, $fixedText, $encUTF8)
        Write-Output "Fixed $file"
    } catch {
        Write-Output "Error on $file"
    }
}
