param(
    [string]$WebsiteName,
    [string]$PhysicalPath,
    [string]$BuildArtifactPath
)

Import-Module WebAdministration

New-Website -Name $websiteName -Port 80 -PhysicalPath $physicalPath

Copy-Item "$buildArtifactPath\*" -Destination $physicalPath -Recurse

Start-Website -Name $websiteName
