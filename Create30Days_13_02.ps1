Add-PSSnapin Microsoft.Sharepoint.Powershell


function Create30Days($siteURL, $listName, $contentType)
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
$newPolicyFeatureXml = "<p:Policy xmlns:p='office.server.policy' local='false' id='5ea8a01a-74e3-49c7-a28d-e9e9e4dcc8aa'>"+
"<p:Name>delete30</p:Name>"+
"<p:Description />"+
"<p:Statement />"+
"<p:PolicyItems>"+
"<p:PolicyItem featureId='Microsoft.Office.RecordsManagement.PolicyFeatures.Expiration' UniqueId='279d8e36-1251-47d7-b525-e9f389568d09'>"+
"<p:Name>хранение</p:Name>"+
"<p:Description>Автоматическое планирование обработки контента и хранения контента, дата выполнения которого истекла.</p:Description>"+
"<p:CustomData>"+"<Schedules nextStageId='2'>"+"<Schedule type='Default'>"+"<stages>"+"<data stageId='1'>"+"<formula id='Microsoft.Office.RecordsManagement.PolicyFeatures.Expiration.Formula.BuiltIn'>"+"<number>30</number>"+"<property>Created</property>"+"<propertyId>8c06beca-0777-48f7-91c7-6da68bc07b69</propertyId>"+"<period>days</period>"+"</formula>"+"<action type='action' id='Microsoft.Office.RecordsManagement.PolicyFeatures.Expiration.Action.Delete' />"+"</data>"+"</stages>"+"</Schedule>"+"</Schedules>"+"</p:CustomData>"+"</p:PolicyItem>"+"</p:PolicyItems>"+"</p:Policy>"

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


$list1 = @('KES_Dopusk','DnES_Dopusk','DES_Dopusk','OES_Dopusk','KRES_Dopusk')

foreach ($i1 in $list1)

{


#Call the function to create a library
Create30Days -siteURL "https://services2013-t02.dtek.com/sites/mobileworkers/grids" -listName $i1 -contentType “Document”

}

$list2 = @('Sh_Yubileynaya_Dopusk','Sh_Geroev_Kosmosa_Dopusk','Sh_ZapadnoDonbasskaya_Dopusk')

foreach ($i2 in $list2)

{


#Call the function to create a library
Create30Days -siteURL "https://services2013-t02.dtek.com/sites/mobileworkers/mines" -listName $i2 -contentType “Document”

}
