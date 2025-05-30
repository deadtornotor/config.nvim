# Path to the requirements file
$requirementsFile = "../requirements/winget.txt"

# Read each line and install the package
Get-Content $requirementsFile | ForEach-Object {
    $package = $_.Trim()
    if ($package -and -not $package.StartsWith("#")) {
        Write-Host "Installing $package..."
        winget install $package --accept-package-agreements --accept-source-agreements
    }
}

Write-Host "You might need to add C:\Program Files\Git\usr\bin\ to your PATH variable"
