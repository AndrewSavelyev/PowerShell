Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue
 
#Function to Grant Permission to List
function Grant-PermissionToList($WebUrl, $ListName, $GroupName, $PermissionLevel)
{
    #Get Web and List objects
    $Web = Get-SPWeb -Identity $WebUrl
    $List = $web.Lists.TryGetList($ListName)
 
    if ($List -ne $null)
    {
        #We must break inheritance to grant permission directly on the list
        if ($List.HasUniqueRoleAssignments -eq $False)
        {
            $list.BreakRoleInheritance($True)
        }
 
        $group = $web.SiteGroups[$GroupName]
                    
        #Get the permission level
        $role = $web.RoleDefinitions[$PermissionLevel]
        $assignment = New-Object Microsoft.SharePoint.SPRoleAssignment($group)
        $assignment.RoleDefinitionBindings.Add($role)
        $list.RoleAssignments.Add($assignment)
        $list.Update()
 
        Write-Host "Granted permission $($PermissionLevel) to $($UserAccount) in list $($ListName)." -foregroundcolor Green       
    }
    $web.Dispose()
}
 
#Call the function to grant access to a list
Grant-PermissionToList "http://sharepoint.crescent.com" "Documents" "Global\Auditors" "Contribute"               


#Read more: https://www.sharepointdiary.com/2014/10/add-remove-permissions-in-sharepoint-using-powershell.html#ixzz7KDfL0bGD