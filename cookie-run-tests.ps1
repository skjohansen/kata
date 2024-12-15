$testStart = Get-Date -Format 'yyyy-MM-dd - HH:mm:ss'

dotnet test --logger "trx" --collect:"XPlat Code Coverage"

reportgenerator -reports:**/TestResults/*/coverage.cobertura.xml -targetdir:coveragereport -reporttypes:TextSummary
$testEnd = Get-Date -Format 'yyyy-MM-dd - HH:mm:ss'
Clear-Host
Write-Output "Current testrun:`n`t🕰️ start: $testStart `n`t🚩 ended: $testEnd"
trx --output