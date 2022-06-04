Add-PSSnapin Microsoft.Sharepoint.Powershell


function Create425Days($siteURL, $listName, $contentType)
{
#Get web object
$web = Get-SPWeb $siteURL
write-host “Examining site:”$web.Title”at”$web.ServerRelativeUrl -ForegroundColor green

try
{
#Do the following if a list exists with the name specified by the user – e.g., Pages
if ($web.Lists[$listName]) {

write-host $web.Title”has a list called “$listName -ForegroundColor green

#Get the list
$list = $web.Lists[$listName]

#Create list policy if one does not exist already
$policy = [Microsoft.Office.RecordsManagement.InformationPolicy.ListPolicySettings]($list)
if (!$policy.ListHasPolicy)
{
$policy.UseListPolicy = $true
$policy.Update()
}

#Get the content type
$ct = $list.ContentTypes[$contentType]

#Create a new policy
[Microsoft.Office.RecordsManagement.InformationPolicy.Policy]::CreatePolicy($ct, $null)
$newPolicy = [Microsoft.Office.RecordsManagement.InformationPolicy.Policy]::GetPolicy($ct)

#Generate policy XML using the values required,
$newPolicyFeatureXml = "<p:Policy xmlns:p='office.server.policy' local='false' id='980103f8-dc68-4f89-9cd3-c58e9e5934e0'>"+
"<p:Name>delete425</p:Name>"+
"<p:Description>delete425</p:Description>"+
"<p:Statement />"+
"<p:PolicyItems>"+
"<p:PolicyItem featureId='Microsoft.Office.RecordsManagement.PolicyFeatures.Expiration' UniqueId='a80de57c-6a5a-4013-bf27-46f3bd2d0472'>"+
"<p:Name>хранение</p:Name>"+
"<p:Description>Автоматическое планирование обработки контента и хранения контента, дата выполнения которого истекла.</p:Description>"+
"<p:CustomData>"+
"<Schedules nextStageId='2'>"+
"<Schedule type='Default'>"+
"<stages>"+
"<data stageId='1'>"+
"<formula id='Microsoft.Office.RecordsManagement.PolicyFeatures.Expiration.Formula.BuiltIn'>"+
"<number>425</number>"+
"<property>Created</property>"+
"<propertyId>8c06beca-0777-48f7-91c7-6da68bc07b69</propertyId>"+
"<period>days</period>"+
"</formula>"+
"<action type='action' id='Microsoft.Office.RecordsManagement.PolicyFeatures.Expiration.Action.Delete' />"+
"</data>"+
"</stages>"+
"</Schedule>"+
"</Schedules>"+
"</p:CustomData>"+
"</p:PolicyItem>"+
"</p:PolicyItems>"+
"</p:Policy>"

#Add retention policy
$newPolicy.Items.Add(“Microsoft.Office.RecordsManagement.PolicyFeatures.Expiration”, $newPolicyFeatureXml)

write-host “Added retention policy to delete documents on content type”$ct.Name”for list”$list.Title”in site”$web.Title
}
else
{
#Report if the site does not have the list specified by the user
write-host $web.Title”does not have a list called “$listName -ForegroundColor red
}
}
catch
{
write-host “There has been an error:”$_ -ForegroundColor red
}
finally
{
#Dispose of the Web object
$web.Dispose()
}
}


$list1 = @('KES_Defekts','DnES_Defekts','DES_Defekts','OES_Defekts','KRES_Defekts')

foreach ($i1 in $list1)

{


#Call the function to create a library
Create425Days -siteURL "https://services2013-t02.dtek.com/sites/mobileworkers/grids" -listName $i1 -contentType “Document”

}

