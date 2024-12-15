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
    git mv $Folder\$($OldName).Application.Test.csproj $Folder\$($NewName).Appplication.Test.csproj
    git mv $Folder\$($OldName)Runner.cs $Folder\$($NewName)Runner.cs

    # # Renaming directories
    # Get-ChildItem -Path . -Directory -Recurse | Sort-Object FullName -Descending | ForEach-Object {
    #     if ($_.Name -match $OldNameRegex) {
    #         $OldPath = $_.Name
    #         $NewPath = $OldPath -replace $OldNameRegex, $NewName
    #         git mv $OldPath $NewPath
    #         Write-Host "Renamed folder: $OldPath -> $NewPath"
    #     }
    # }

    # # Renaming files
    # Get-ChildItem -Path . -File -Recurse | Sort-Object FullName -Descending | ForEach-Object {
    #     if ($_.Name -match $OldNameRegex) {
    #         $OldPath = $_.Name
    #         $NewPath = $OldPath -replace $OldNameRegex, $NewName
    #         git mv $OldPath $NewPath
    #         Write-Host "Renamed file: $OldPath -> $NewPath"
    #     }
    # }
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
