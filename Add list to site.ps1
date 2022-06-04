#PowerShell Function to Create a Document Library in SharePoint
Function Create-DocumentLibrary
{
Param([Microsoft.SharePoint.SPWeb]$Web,[String] $LibraryName,[String] $Description)
    #Get the Document Library template
    $ListTemplate = [Microsoft.Sharepoint.SPListTemplateType]::DocumentLibrary
   
    #Check if the library already exists
    if(($web.Lists.TryGetList($LibraryName)) -eq $null)
    {
        #Create the Library
        $Web.Lists.Add($LibraryName,$Description,$ListTemplate) > Null
    
        #Set Properties of Library such as OnQuickLaunch, etc
        $Library =  $Web.Lists[$LibraryName]
        $Library.OnQuickLaunch = $true
        $Library.Update()
    
        Write-Host "Document library created successfully!" -f Green
    }
    else
    {
        Write-Host "Document Library '$LibraryName' already exists!" -f Red
    }
}
  
#Get the Web
$web = Get-SPWeb https://services2013-t01.dtek.com/mobileworkers/grids
  
#Call the function to create a library
Create-DocumentLibrary $web "TEST1" "Test Library 1"
Create-DocumentLibrary $web "TEST2" "Test Library 2"

$lists = @('КЭС_Допуск','КЭС_Подтверждения','КЭС_Дефекты')

foreach ($i in $lists)

{

#Call the function to create a library
Create-DocumentLibrary $web $i $i

}

'KES_Dopusk','KES_Podtverzhdeniya','KES_Defekts','KES_Dokumentatsiya','DnES_Dopusk','DnES_Podtverzhdeniya','DnES_Defekts','DnES_Dokumentatsiya','DES_Dopusk','DES_Podtverzhdeniya','DES_Defekts','DES_Dokumentatsiya','OES_Dopusk','OES_Podtverzhdeniya','OES_Defekts','OES_Dokumentatsiya','KRES_Dopusk','KRES_Podtverzhdeniya','KRES_Defekts','KRES_Dokumentatsiya'

'Sh_Yubileynaya_Dopusk','Sh_Yubileynaya_Podtverzhdeniya','Sh_Yubileynaya_Defekt','Sh_Yubileynaya_Dok','Sh_Geroev_Kosmosa_Dopusk','Sh_Geroev_Kosmosa_Podtverzhdeniya','Sh_Geroev_Kosmosa_Defekt','Sh_Geroev_Kosmosa_Dok','Sh_ZapadnoDonbasskaya_Dopusk','Sh_ZapadnoDonbasskaya_Podtverzhdeniya','Sh_Zapadno_Donbasskaya_Defekt','Sh_ZapadnoDonbasskaya_Dok'

'ZaTES_Defekt','KyTES_Defekt','LyTES_Defekt','KpTES_Defekt','LaTES_Defekt'

$lists = @('Sh_Yubileynaya_Dopusk','Sh_Yubileynaya_Podtverzhdeniya','Sh_Yubileynaya_Defect','Sh_Yubileynaya_Doc','Sh_Geroev_Kosmosa_Dopusk','Sh_Geroev_Kosmosa_Podtverzhdeniya','Sh_Geroev_Kosmosa_Defect','Sh_Geroev_Kosmosa_Doc','Sh_ZapadnoDonbasskaya_Dopusk','Sh_ZapadnoDonbasskaya_Podtverzhdeniya','Sh_Zapadno_Donbasskaya_Defect','Sh_ZapadnoDonbasskaya_Doc')
