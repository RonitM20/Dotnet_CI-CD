$all_RGs=(Get-AzResourceGroup).resourcegroupname
$rgname= "test" 
$ron=(get-azresourcegroup | where{$_.ResourceGroupName -match $rgname}).resourcegroupname  
foreach ($r in $ron) {
#$last3=@()
$last3=($r -replace '\D+(\d+)','$1') -split "00",-2 | Sort-Object
[array]$last3
}
$test= $last3 | measure -Maximum  
$ram=$test.Maximum
$rom= ++$ram

$final = $rgname + $rom

Write-Output $final
