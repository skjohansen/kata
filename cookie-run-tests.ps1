dotnet test --logger "trx" --collect:"XPlat Code Coverage"

reportgenerator -reports:**/TestResults/*/coverage.cobertura.xml -targetdir:coveragereport -reporttypes:TextSummary
Clear-Host
trx --output