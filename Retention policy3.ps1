https://social.msdn.microsoft.com/Forums/sharepoint/en-US/f43eda0e-d8d9-494a-9f27-b2a16a545c98/document-retention-policy-using-powershell-script-in-sharepoint-2010?forum=sharepointdevelopmentprevious

Add-PSSnapin Microsoft.SharePoint.Powershell
[Microsoft.SharePoint.SPSite]$Site = Get-SPSite http://site/
[Microsoft.SharePoint.SPWeb]$web = Get-SPWeb http://site/
$ContentTypeGroup="Extranet"



$Site.RootWeb.ContentTypes | where { $_.Group -match $ContentTypeGroup } | ForEach-Object {
            
    $contentTypeName = $_.Name
    $ctype = $web.ContentTypes[$contentTypeName]   
    if($ctype.Name -eq $null)
    {
         Write-Warning($contentTypeName + " does not exist")
    }
    else
    { 

            $ctypePolicy = [Microsoft.Office.RecordsManagement.InformationPolicy.Policy]::GetPolicy($ctype);
            if($ctypePolicy -ne $null)
            {
                Write-Host $ctype.Name "Has an existing Policy" $ctypePolicy "and is being deleted" -ForegroundColor Magenta
                [Microsoft.Office.RecordsManagement.InformationPolicy.Policy]::DeletePolicy($ctype);
            }

            [Microsoft.Office.RecordsManagement.InformationPolicy.Policy]::CreatePolicy($ctype, $null);

            $ctypePolicy = [Microsoft.Office.RecordsManagement.InformationPolicy.Policy]::GetPolicy($ctype);

            $ctypePolicy.Items.Add("Microsoft.Office.RecordsManagement.PolicyFeatures.Expiration",
	        "<Schedules nextStageId='3' default='false'> " +
	        "<Schedule type='Default'> " +
	        "<stages /></Schedule> " +
	        "<Schedule type='Record'> " +
	        "<stages> " +
		        "<data stageId='1'> " +
			        "<formula id='Microsoft.Office.RecordsManagement.PolicyFeatures.Expiration.Formula.BuiltIn'> " +
				        "<number>7</number> " +
				        "<property>Created</property> " +
				        "<propertyId>8c06beca-0777-48f7-91c7-6da68bc07b69</propertyId> " +
				        "<period>years</period> " +
			        "</formula> " +
			        "<action type='action' id='Microsoft.Office.RecordsManagement.PolicyFeatures.Expiration.Action.DeletePreviousVersions' /> " +
		        "</data>" +
		        "<data stageId='2'> " +
			        "<formula id='Microsoft.Office.RecordsManagement.PolicyFeatures.Expiration.Formula.BuiltIn'> " +
				        "<number>10</number> " +
				        "<property>Created</property> " +
				        "<propertyId>8c06beca-0777-48f7-91c7-6da68bc07b69</propertyId> " +
				        "<period>years</period> " +
			        "</formula> " +
			        "<action type='workflow' id='8daba39c-fd11-4f7f-836b-b179a1238782' /> " +
		        "</data> " +		
	        "</stages> " +
	        "</Schedule> " +
	        "</Schedules> ");
                $ctypePolicy.Update();
                $ctype.Update();
            Write-Host "The Policy For" $ctype.Name "Has Been Created And Applied!" -ForegroundColor Green
     }

  }