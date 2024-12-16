# Get-Content -Path ".\coveragereport\Summary.txt" -Wait

# Path to the file you want to watch
$filePath = ".\coveragereport\Summary.txt"

# Time interval for checking changes (in seconds)
$interval = 2

# Last modification time of the file
$lastModified = (Get-Item $filePath).LastWriteTime

Clear-Host
Get-Content $filePath

while ($true) {
    # Get the current modification time
    $currentModified = (Get-Item $filePath).LastWriteTime

    # If the file has been modified
    if ($currentModified -ne $lastModified) {
        # Update the last modification time
        $lastModified = $currentModified

        # Clear the screen
        Clear-Host

        # Print the contents of the file
        Get-Content $filePath
    }

    # Wait for the specified interval before checking again
    Start-Sleep -Seconds $interval
}
