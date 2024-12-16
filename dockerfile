FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /app

# Copy the .csproj and restore as distinct layers
COPY source/Kata.Application/Kata.Application.csproj source/Kata.Application/Kata.Application.csproj
COPY source/Kata.Logic/Kata.Logic.csproj source/Kata.Logic/Kata.Logic.csproj
COPY tests/Kata.Application.Test/Kata.Application.Test.csproj tests/Kata.Application.Test/Kata.Application.Test.csproj
COPY tests/Kata.Logic.Test/Kata.Logic.Test.csproj tests/Kata.Logic.Test/Kata.Logic.Test.csproj
COPY *.sln ./
RUN dotnet restore

# Copy the remaining source code and build the application
COPY tests/ tests
COPY source/ source
RUN dotnet build
RUN dotnet test
RUN dotnet publish -c Release -o out

# ---FINAL STAGE---
FROM cgr.dev/chainguard/dotnet-runtime:latest AS final
WORKDIR /
COPY --from=build /app/out .
ENTRYPOINT ["dotnet", "Kata.Application.dll"]



