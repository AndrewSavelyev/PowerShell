Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue
Function Add-FieldToList($SiteURL, $ListName, $FieldName, $FieldType, $IsRequired)
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

$library = @('DnES_Dokumentatsiya','DnES_Dokumentatsiya')

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



Latitude	Однострочный текст	
Longitude	Однострочный текст	
ToroOrderCode		Однострочный текст	
TechnicalObjectCode		Однострочный текст	
PersonnelNumber		Однострочный текст	
DefectCode		Однострочный текст	
Comment		Многострочный текст

$library = @('Ш_Юбилейная_Допуск','Ш_Юбилейная_Подтверждения','Ш_Юбилейная_Дефекты','Ш_Юбилейная_Документация','Ш_им_Героев Космоса_Допуск','Ш_им_Героев_Космоса_Подтверждения','Ш_им_Героев_Космоса_Дефекты','Ш_им_Героев_Космоса_Документация','Ш_Западно-Донбасск'ая_Допуск','Ш_Западно-Донбасск'ая_Подтверждения','Ш_Западно-Донбасск'ая_Дефекты','Ш_Западно-Донбасск'ая_Докуменация')

$library = @('ЗаТЭС_Дефекты','КуТЭС_Дефекты','ЛуТЭС_Дефекты','Кр_ТЭС_Дефекты','ЛаТЭС_Дефекты')

$library = @('КЭС_Допуск','КЭС_Подтверждения','КЭС_Дефекты','КЭС_Документация','ДнЭС_Допуск','ДнЭС_Подтверждения','ДнЭС_Дефекты','ДнЭС_Документация','ДЭС_Допуск','ДЭС_Подтверждения','ДЭС_Дефекты','ДЭС_Документация','ОЭС_Допуск','ОЭС_Подтверждения','ОЭС_Дефекты','ОЭС_Документация','КРЭС_Допуск','КРЭС_Подтверждения','КРЭС_Дефекты','КРЭС_Документация')

