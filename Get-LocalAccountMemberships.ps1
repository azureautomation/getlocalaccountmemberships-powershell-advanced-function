Function Get-LocalAccountMemberships
{
	<#
	.SYNOPSIS
		Retrieves local user accounts and their group memberships.
 
	.DESCRIPTION
		Retrieves local user accounts and their group memberships. For having the Output prepared for a 
		Custon Script Extension in Azure Export-Clixml is being used which can then be deserialized with 
		Import-Clixml.
 
	.PARAMETER ComputerName
		A single Computer or an array of computer names. The default is localhost ($env:COMPUTERNAME).

	.PARAMETER GroupName
		A single stirng or array of Groups to be verified.
 
	.EXAMPLE
		PS C:\> Get-LocalAccountMemberships -GroupName Users,Adminsitrators
 
	.NOTES
		Author:  Sebastian Gräf
		Email:   ps@graef.io
		Date:    December 15, 2017
		PSVer:   3.0/4.0/5.0
	#>
	param(
    [parameter(ValueFromPipeline=$true,ValueFromPipelineByPropertyName=$true)]  
    [array]$ComputerName = $Env:COMPUTERNAME,
    [array]$GroupName
    )

    $results = @()
    $arr = @()
	$LocalAccounts = Get-WmiObject -ComputerName $ComputerName -Class Win32_UserAccount -Filter "LocalAccount='$True'"
	foreach($LocalAccount in $LocalAccounts)
	{
        $obj = New-Object PSObject
		$obj | Add-Member NoteProperty "LocalAccount" $LocalAccount.Caption
		$obj | Add-Member NoteProperty "Disabled" $LocalAccount.Disabled
		foreach($Group in $GroupName)
		{
			$wmi = Get-WmiObject -ComputerName $ComputerName -Query "SELECT * FROM Win32_GroupUser WHERE GroupComponent=`"Win32_Group.Domain='$ComputerName',Name='$Group'`""
			foreach ($item in $wmi)  
			{  
				$data = $item.PartComponent -split "\," 
				$domain = ($data[0] -split "=")[1] 
				$name = ($data[1] -split "=")[1] 
				$arr += ("$domain\$name").Replace("""","")
			}
			if($arr -contains $LocalAccount.Caption)
			{
				$obj | Add-Member NoteProperty "$Group" "true"
			}
            else
            {
				$obj | Add-Member NoteProperty "$Group" "false"
            }
		}
		$results+=$obj
	}
    $results
}
$output = Get-LocalAccountMemberships -GroupName Users,Administrators | Export-Clixml output.xml
gc output.xml
