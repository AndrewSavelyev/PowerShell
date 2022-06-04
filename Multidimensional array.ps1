System.Collections.ArrayList]$scoreDetails = @()
$scoreDetails = @( @('Aadharsh', '200'), @('Rakshu', '199') )
 
#Get user input and ADD to multi-dimensional array
Write-Host "Enter NEXT person score details"
$name = Read-Host "Name"
$score = Read-host "Score"
#Each time we put a comma, we are like telling Powershell to start a new row in the multidimensional array
$scoreDetails+= ,(@($name,$score))
 
for($parentLoop=0; $parentLoop -lt 3; $parentLoop++)
{
	for($childLoop=0; $childLoop -lt 2 ; $childLoop++)
		{
		"The value of [$parentLoop][$childLoop] ---> " +$scoreDetails[$parentLoop][$childLoop]
		}
 
}

