param($url = $(Read-Host -prompt "Root Site Collection Path"))

#Get the PowerShell Snapin
Add-PSSnapin "Microsoft.SharePoint.PowerShell"

#Search Service Application
$ssa = Get-SPEnterpriseSearchServiceApplication
Write-Host $ssa.Name -ForegroundColor Magenta

#Get Site
$site = Get-SPSite $url

#Get Root Web
$web = $site.RootWeb

#Write Out That The Web Was Found
if($web -ne $null)
{
    Write-Host "The web is" $web "and the site is" $site.HostName -ForegroundColor Magenta

}

#Fill the array with base content types i.e. Exelon Content Page
$parentCtypes = @("Content Page");

foreach ($ctype in $web.ContentTypes)
{
    foreach($i in $parentCtypes)
    {
        if($ctype.Name -eq $i)
        {
            Write-Host $ctype.Name "is the same as" $i -ForegroundColor Magenta
            $ctypePolicy = [Microsoft.Office.RecordsManagement.InformationPolicy.Policy]::GetPolicy($ctype);
            if($ctypePolicy -ne $null)
            {
                Write-Host $ctype.Name "Has an existing Policy" $ctypePolicy "and is being deleted" -ForegroundColor Magenta
                [Microsoft.Office.RecordsManagement.InformationPolicy.Policy]::DeletePolicy($ctype);
            }
            [Microsoft.Office.RecordsManagement.InformationPolicy.Policy]::CreatePolicy($ctype, $null);
            $ctypePolicy = [Microsoft.Office.RecordsManagement.InformationPolicy.Policy]::GetPolicy($ctype);
            $ctypePolicy.Items.Add("Microsoft.Office.RecordsManagement.PolicyFeatures.Expiration",
                "<Schedules nextStageId='2'>"+
                    "<Schedule type='Default'>"+
                        "<stages>"+
                            "<data stageId='1'>"+
                                "<formula id='Microsoft.Office.RecordsManagement.PolicyFeatures.Expiration.Formula.BuiltIn'>"+
                                    "<number>0</number>"+
                                    "<property>ExpirationDate</property>"+
                                    "<propertyId>8c06beca-0777-48f7-91c7-6da68bc07b69</propertyId>"+
                                    "<period>days</period>"+
                                "</formula>"+
                                "<action type='action' id='Microsoft.Office.RecordsManagement.PolicyFeatures.Expiration.Action.Record' />"+
                            "</data>"+
                        "</stages>"+
                    "</Schedule>"+
                "</Schedules>");
                $ctypePolicy.Update();
                $ctype.Update();
            Write-Host "The Policy For" $ctype.Name "Has Been Created And Applied!" -ForegroundColor Green
        }
    }
}