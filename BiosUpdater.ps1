#Gets bios settings
$biosInfo = Get-WmiObject -Namespace root/hp/instrumentedBIOS -Class hp_biosEnumeration | select Name, currentvalue

#List of Bios values to be changed from Disable to Enable.  Can add new values with:  , "valuename" 
$listedValues = "Sunday",  "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Wake On Lan", "Wake on LAN on DC mode"

#only for switching disable to enabled
foreach ( $ind in $biosInfo ) {
    foreach ( $name in $listedValues ) {
        if ($name -eq $ind.Name) {
            if ($ind.currentvalue -eq "Disable") {
                $bios = Get-WmiObject -Namespace root/hp/instrumentedBIOS -Class HP_BIOSSettingInterface
                $bios.setbiossetting($ind.Name, "Enable","")
            }
        }
    }
}