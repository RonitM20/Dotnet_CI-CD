$rgname= "test" 
$ron=(get-azresourcegroup | where{$_.ResourceGroupName -match $rgname}).resourcegroupname
$div = ($ron -replace '\D+(\d+)','$1') -split "00",-2 | Sort-Object
$div = $div |  Select -Last 1
$div = [int]$div + 1
$a = $ron | Select -Last 1
$b = $a.Substring(0,4)
$c = $b + $div
Write-Output $c