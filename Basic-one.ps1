param(
    [string]$WebsiteName
    [string]$PhysicalPath
    [string]$buildArtifactPath
)

Import-Module WebAdministration

# Create a new website
New-Website -Name $websiteName -Port 80 -PhysicalPath $physicalPath

# Copy the build artifact to the website's physical path
Copy-Item "$buildArtifactPath\*" -Destination $physicalPath -Recurse

# Start the website
Start-Website -Name $websiteName