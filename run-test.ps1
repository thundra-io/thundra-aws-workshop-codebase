
if ((Test-Path "./test/chromedriver.exe") -eq $false) {
    Write-Host "Couldn't find the ChromeDriver in the test folder."
    Write-Host "Please download suitable version from https://chromedriver.storage.googleapis.com/index.html"
    Write-Host "Find out your Chrome version by visiting chrome://settings/help"
    exit 1
}


$DotEnvFile = "./.env"

function ExportEnvironmentVariable {

    if( !( Test-Path $DotEnvFile))
    {
        Write-Host "DotEnv file not found."
        exit 1
    }

    $DotEnvFileContent = Get-Content $DotEnvFile -ErrorAction Stop

    foreach ($line in $DotEnvFileContent)
    {
        if ($line -match "^#") {
            continue
        }

        $line = $line.Trim()
        $line = $line.Replace("=", " ")
        $line = $line.Trim()
        $line = $line.Split(" ")

        $key = $line[0]
        $value = $line[1]

        if ($key -eq "") {
            continue
        }

        if ($value -eq "") {
            continue
        }

        [Environment]::SetEnvironmentVariable($key, $value, "Process") | Out-Null
    }

}


ExportEnvironmentVariable

cd "./test"

mvn clean install

cd ..
