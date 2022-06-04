#Config Variables
$SiteURL = "https://crescent.sharepoint.com/sites/ops/"
$LibraryName = "Documents"
   
#Connect to PnP Online
Connect-PnPOnline -Url $SiteURL -Interactive
 
#Define Query to Filter Files that were 'Created' 30 days ago (or More!)
$Query= "<View Scope='RecursiveAll'>
            <Query>
                <Where>
                    <And>
                        <Lt>
                            <FieldRef Name='Created' Type='DateTime'/>
                            <Value Type='DateTime' IncludeTimeValue='TRUE'>
                                <Today OffsetDays='-30'/>
                            </Value>
                        </Lt>
                        <Eq>
                            <FieldRef Name='FSObjType' /><Value Type='Integer'>0</Value>
                        </Eq>
                    </And>
                </Where>
            </Query>
        </View>"
 
#Get All Files matching the query
$Files = Get-PnPListItem -List $LibraryName -Query $Query -PageSize 500
   
#Loop through each File
Write-host -f Green "Total Number of Files Found:"$Files.Count
ForEach($File in $Files)
{
    #Send File to recycle bin
    Write-Host "Deleting File Created On:" $File.FieldValues.Created -f Yellow
    Move-PnPListItemToRecycleBin -List $LibraryName -Identity $File.Id -Force
    Write-Host "`tDeleted File at:" $File.FieldValues.FileRef -f Green


#Read more: https://www.sharepointdiary.com/2019/04/sharepoint-online-delete-files-older-than-30-days-using-powershell.html#ixzz7IJFRfViT