param (
[string]$WebsiteName,
[string]$AppPoolName,
[string]$PhysicalPath,
[string]$Protocol
)

 

Import-Module WebAdministration

 

copy-item "$(System.DefaultWorkingDirectory)/_Ron_devops (1)/Azurebuildpipeline/Helloworldapp.web.zip" -Destination $PhysicalPath -Recurse

 

# Check if website already exists
if (-not(Test-Path IIS:\Sites\$WebsiteName)) {
# Create the website
New-Item IIS:\Sites\$WebsiteName -bindings @{protocol=$Protocol;bindingInformation=":80:"} -physicalPath $PhysicalPath
}else {Write-Output 'Site already there'}

 

# Check if app pool already exists
if (-not(Test-Path IIS:\AppPools\$AppPoolName)) {
# Create the app pool
New-Item IIS:\AppPools\$AppPoolName
}

 

# Assign the app pool to the website
Set-ItemProperty IIS:\Sites\$WebsiteName -name applicationPool -value $AppPoolName

 

Write-Output 'End of site deployment'