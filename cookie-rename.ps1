# Script to rename folders/files and update namespaces/classes in file contents
param (
    [string]$NewAppName
)

# Function to rename directories and files using `git mv`
function Rename-GitObjects {
    param (
        [string]$OldName,  # Regex pattern for the old application name
        [string]$NewName        # New application name
    )

    # Rename folders
    git mv source\$($OldName).Application source\$($NewName).Application
    git mv source\$($OldName).Logic source\$($NewName).Logic
    git mv tests\$($OldName).Application.Test tests\$($NewName).Application.Test
    git mv tests\$($OldName).Logic.Test tests\$($NewName).Logic.Test

    # Rename logic files
    $Folder = "source\$($NewName).Logic"
    Write-Host "Rename files in: $Folder"
    git mv $Folder\$($OldName).Logic.csproj $Folder\$($NewName).Logic.csproj
    git mv $Folder\$($OldName).cs $Folder\$($NewName).cs

    # Rename application files
    $Folder = "source\$($NewName).Application"
    Write-Host "Rename files in: $Folder"
    git mv $Folder\$($OldName).Application.csproj $Folder\$($NewName).Application.csproj
    git mv $Folder\$($OldName)Runner.cs $Folder\$($NewName)Runner.cs

    # Rename logic tests
    $Folder = "tests\$($NewName).Logic.Test"
    Write-Host "Rename files in: $Folder"
    git mv $Folder\$($OldName).Logic.Test.csproj $Folder\$($NewName).Logic.Test.csproj
    git mv $Folder\$($OldName)Tests.cs $Folder\$($NewName)Tests.cs
    
    
    # Rename application tests
    $Folder = "tests\$($NewName).Application.Test"
    Write-Host "Rename files in: $Folder"
    git mv $Folder\$($OldName).Application.Test.csproj $Folder\$($NewName).Application.Test.csproj
    git mv $Folder\$($OldName)Runner.cs $Folder\$($NewName)Runner.cs

    # Solution files
    Write-Host "Rename solution"
    git mv kata.sln $NewName".sln"
}

# Function to update file content with new namespaces and classes
function Update-NamespacesAndClasses {
    param (
        [string]$OldName,
        [string]$NewName
    )

    # rename in source
    Get-ChildItem -Path ./source -File -Recurse | ForEach-Object {
        $FilePath = $_.FullName
        (Get-Content -Path $FilePath) -replace $OldName, $NewName | Set-Content -Path $FilePath
        Write-Host "Updated file: $FilePath"
    }

    # rename in test
    Get-ChildItem -Path ./tests -File -Recurse | ForEach-Object {
        $FilePath = $_.FullName
        (Get-Content -Path $FilePath) -replace $OldName, $NewName | Set-Content -Path $FilePath
        Write-Host "Updated file: $FilePath"
    }

    # rename single files
    (Get-Content -Path $NewName".sln") -replace $OldName, $NewName | Set-Content -Path $NewName".sln"
    (Get-Content -Path "dev-clear-results.ps1") -replace $OldName, $NewName | Set-Content -Path "dev-clear-results.ps1"
    (Get-Content -Path "dockerfile") -replace $OldName, $NewName | Set-Content -Path "dockerfile"
    (Get-Content -Path "README.md") -replace $OldName, $NewName | Set-Content -Path "README.md"
}

# Main Script Logic
if (-not $NewAppName) {
    Write-Error "You must provide the new application name as a parameter."
    exit 1
}

# Define the old application name based on folder structure or naming convention
$OldAppName = "Kata" # Replace this with the logic to determine the old name, if necessary.

Write-Host "Renaming folders and files from '$OldAppName' to '$NewAppName'..."
Rename-GitObjects -OldName $OldAppName -NewName $NewAppName

# Write-Host "Updating namespaces and class references..."
Update-NamespacesAndClasses -OldName $OldAppName -NewName $NewAppName

Write-Host "Renaming and updates complete."
Write-Host "---- Next step:"
Write-Host "Add changes to git: git add ."
Write-Host "Commit changes to git: git commit -m ""refactor: Rename to $NewAppName"""