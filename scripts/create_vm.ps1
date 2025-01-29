if (-not (docker images windows-local -q)) {
    Write-Host "Image not found locally. Building..."
    docker build -t windows-local ..
} else {
    Write-Host "Image found locally. Skipping build."
}

docker compose -f ../compose.yml up

while ($true) {
    try {
        $response = Invoke-WebRequest -Uri "http://localhost:5000/probe" -Method GET -UseBasicParsing
        if ($response.StatusCode -eq 200) {
            break
        }
    } catch {
        Write-Host "Waiting for a response from the computer control server. When first building the VM storage folder this can take a while..."
        Start-Sleep -Seconds 5
    }
}

Write-Host "VM + server is up and running!"