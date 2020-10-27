Get-LocalAccountMemberships PowerShell Advanced Function
========================================================

            

Okay, yeah there are plenty of scripts out which give you local accounts via WMI or ADSI and yes scripts exist also which give you all local groups but there is not one which gives you both (of course there are also some) but what if you're looking to implement
 this as a CustomScriptExtension to your Azure VM? Especially if the Custom Script Extension Output is limited to only 4096 characters? Did you know that? This script was developed to minimize the output of local accounts and their group memberships and gives
 you a meaningful expression of user accounts sitting on your VM.


 


 

 

        
    
TechNet gallery is retiring! This script was migrated from TechNet script center to GitHub by Microsoft Azure Automation product group. All the Script Center fields like Rating, RatingCount and DownloadCount have been carried over to Github as-is for the migrated scripts only. Note : The Script Center fields will not be applicable for the new repositories created in Github & hence those fields will not show up for new Github repositories.
