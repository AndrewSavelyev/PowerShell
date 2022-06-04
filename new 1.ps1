Function Add-FieldToList($SiteURL, $ListName, $FieldName, $FieldType, $IsRequired)
{
#Set the Error Action
$ErrorActionPreference = "Stop"
Try{
#Get the List
$List = (Get-SPWeb $SiteURL).Lists.TryGetList($ListName)
#Check if List with specific name existsFunction Add-FieldToList($SiteURL, $ListName, $FieldName, $FieldType, $IsRequired)
{
#Set the Error Action
$ErrorActionPreference = "Stop"
Try{
#Get the List
$List = (Get-SPWeb $SiteURL).Lists.TryGetList($ListName)
#Check if List with specific name exists
if($List -ne $null)
{
if(!$List.Fields.ContainsField($FieldName))
{ 
#Add columns to the List
$List.Fields.Add($FieldName,$FieldType,$IsRequired)

#Update the List
$List.Update()

#Update the default view to include the new column
$View = $List.DefaultView # OR $List.Views["All Items"]
$View.ViewFields.Add($FieldName)
$View.Update()

write-host "New Column '$FieldName' Added to the List!" -ForegroundColor Green
}
else
{
write-host "Field '$FieldName' Already Exists in the List" -ForegroundColor Red
}
}
else
{
write-host "List '$ListName' doesn't exists!" -ForegroundColor Red
} 
}
catch {
Write-Host $_.Exception.Message -ForegroundColor Red
}
finally {
#Reset the Error Action to Default
$ErrorActionPreference = "Continue"
}
}

#Parameters
$SiteURL = https://services2013-t01.dtek.com/mobileworkers/grids
$ListName = "ДЭС_Подтверждения"



#Add 'Name' - Single Line of Text Field
$FieldType = [Microsoft.SharePoint.SPFieldType]::Text
$FieldName = "Name22"
$IsRequired = $False
#Call the function to Add Field to List
Add-FieldToList $SiteURL $ListName $FieldName $FieldType $IsRequired

#Add Phone Number - Number Field
$FieldType = [Microsoft.SharePoint.SPFieldType]::Number
$FieldName = "Phone Number"
$IsRequired = $False
#Call the funtion to Add Field to List
Add-FieldToList $SiteURL $ListName $FieldName $FieldType $IsRequired

#Date of Joing - Date Field
$FieldType = [Microsoft.SharePoint.SPFieldType]::DateTime
$FieldName = "Date of Join"
$IsRequired = $False
#Call the funtion to Add Field to List
Add-FieldToList $SiteURL $ListName $FieldName $FieldType $IsRequired

if($List -ne $null)
{
if(!$List.Fields.ContainsField($FieldName))
{ 
#Add columns to the List
$List.Fields.Add($FieldName,$FieldType,$IsRequired)

#Update the List
$List.Update()

write-host "New Column '$FieldName' Added to the List!" -ForegroundColor Green
}
else
{
write-host "Field '$FieldName' Already Exists in the List" -ForegroundColor Red
}
}
else
{
write-host "List '$ListName' doesn't exists!" -ForegroundColor Red
} 
}
catch {
Write-Host $_.Exception.Message -ForegroundColor Red
}
finally {
#Reset the Error Action to Default
$ErrorActionPreference = "Continue"
}
}

#Parameters
$SiteURL = 'https://services2013-t02.dtek.com/sites/mobileworkers'


$library = @('КЭС_Допуск','КЭС_Подтверждения','КЭС_Дефекты','КЭС_Документация','ДнЭС_Допуск','ДнЭС_Подтверждения','ДнЭС_Дефекты','ДнЭС_Документация','ДЭС_Допуск','ДЭС_Подтверждения','ДЭС_Дефекты','ДЭС_Документация','ОЭС_Допуск','ОЭС_Подтверждения','ОЭС_Дефекты','ОЭС_Документация','КРЭС_Допуск','КРЭС_Подтверждения','КРЭС_Дефекты','КРЭС_Документация',)

foreach ($i in $library)

{

#Add 'Name' - Single Line of Text Field
$FieldType = [Microsoft.SharePoint.SPFieldType]::Text
$FieldName = "Latitude"
$IsRequired = $False
#Call the function to Add Field to List
Add-FieldToList $SiteURL $i $FieldName $FieldType $IsRequired

#Add 'Name' - Single Line of Text Field
$FieldType = [Microsoft.SharePoint.SPFieldType]::Text
$FieldName = "Longitude"
$IsRequired = $False
#Call the function to Add Field to List
Add-FieldToList $SiteURL $i $FieldName $FieldType $IsRequired

#Add 'Name' - Single Line of Text Field
$FieldType = [Microsoft.SharePoint.SPFieldType]::Text
$FieldName = "ToroOrderCode"
$IsRequired = $False
#Call the function to Add Field to List
Add-FieldToList $SiteURL $i $FieldName $FieldType $IsRequired

#Add 'Name' - Single Line of Text Field
$FieldType = [Microsoft.SharePoint.SPFieldType]::Text
$FieldName = "TechnicalObjectCode"
$IsRequired = $False
#Call the function to Add Field to List
Add-FieldToList $SiteURL $i $FieldName $FieldType $IsRequired

#Add 'Name' - Single Line of Text Field
$FieldType = [Microsoft.SharePoint.SPFieldType]::Text
$FieldName = "PersonnelNumber"
$IsRequired = $False
#Call the function to Add Field to List
Add-FieldToList $SiteURL $i $FieldName $FieldType $IsRequired

#Add 'Name' - Single Line of Text Field
$FieldType = [Microsoft.SharePoint.SPFieldType]::Text
$FieldName = "DefectCode"
$IsRequired = $False
#Call the function to Add Field to List
Add-FieldToList $SiteURL $i $FieldName $FieldType $IsRequired

#Add 'Name' - Multiple Line of Text Field
$FieldType = [Microsoft.SharePoint.SPFieldType]::Note 
$FieldName = "Comment"
$IsRequired = $False
#Call the function to Add Field to List
Add-FieldToList $SiteURL $i $FieldName $FieldType $IsRequired

}