# BatteryNotifier.ps1

# Function to check battery status and display notification
function Check-BatteryStatus {
    $battery = Get-WmiObject -Class Win32_Battery

    # Check if the battery is present
    if ($battery) {
        $plugged = $battery.PowerPlugged
        $percent = $battery.EstimatedChargeRemaining

        if ($plugged -eq $true -and $percent -eq 100) {
            # Battery is fully charged
            [System.Windows.Forms.MessageBox]::Show("Battery is fully charged. Unplug your charger!", "Battery Notification", "OK", [System.Windows.Forms.MessageBoxIcon]::Information)
        }
        elseif ($plugged -eq $false -and $percent -le 10) {
            # Battery is low
            [System.Windows.Forms.MessageBox]::Show("Battery is low. Connect your charger!", "Battery Notification", "OK", [System.Windows.Forms.MessageBoxIcon]::Warning)
        }
    }
}

# Infinite loop to check battery status every 5 minutes
while ($true) {
    Check-BatteryStatus
    Start-Sleep -Seconds 300  # Sleep for 5 minutes
}
