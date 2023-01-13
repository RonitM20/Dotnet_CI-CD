param (
[string]$WebSiteName,
[string]$WebSitePath,
[string]$Port,
[string]$Protocol,
[string]$AppPool
)
{
    Import-Module WebAdministration
}
$IsNewSite = $False
$WebSiteDetails= Get-ChildItem -Path IIS:\Sites
$IISAppPool = Get-ChildItem –Path IIS:\AppPools 
Write-Output 'Starting Website Deployment in IIS'
foreach($siteName in $WebSiteDetails.Name){
  if($siteName -eq $WebSiteName){
     $IsNewSite=$False
     break
   }else{
     $IsNewSite=$true
   }
}
if($IsNewSite){
   $IspoolExists=$False
   Write-Output 'New Site'
   foreach($Pool in $IISAppPool){
     if($Pool.Name -eq 'DefaultAppPool'){ 
       #You can update the Pool name with variable declared at top and pass it from TFS Release Management
       $IspoolExists=$true
      }
   }
   if(-not $IspoolExists){
     #New-Item IIS:\AppPools\$AppPool
     Write-Output 'Pool Not Available'
  }else{
    Write-Output 'Pool Exists'
    New-Item IIS:\Sites\$WebSiteName -physicalPath $WebSitePath -bindings @{protocol= $Protocol ;bindingInformation=$Port}
    Set-ItemProperty IIS:\Sites\$WebSiteName -name applicationPool -value 'DefaultAppPool' #You can update the Pool name with variable declared at top and pass it from TFS Release Management
  }

}else{
    Write-Output 'Site Already Exists'
}
Write-Output 'End Website Deployment in IIS'