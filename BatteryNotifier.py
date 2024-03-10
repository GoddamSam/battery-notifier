# BatteryNotifier.py
import psutil
from win10toast import ToastNotifier
import time

def get_battery_status():
    battery = psutil.sensors_battery()
    plugged = battery.power_plugged
    percent = battery.percent
    return plugged, percent

def notify(message):
    toaster = ToastNotifier()
    toaster.show_toast('Battery Notification', message, duration=10)

def main():
    while True:
        plugged, percent = get_battery_status()

        if plugged and percent == 100:
            notify('Battery is fully charged. Unplug your charger!')
        elif not plugged and percent <= 10:
            notify('Battery is low. Connect your charger!')

        # Check every 5 minutes
        time.sleep(300)

if __name__ == "__main__":
    main()
