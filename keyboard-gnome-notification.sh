#!/bin/bash
# Flash keyboard backlight on GNOME notifications

# Configuration
LED="/sys/class/leds/tpacpi::kbd_backlight/brightness"
FLASH_COUNT=4
FLASH_DURATION=0.2  # How long each flash stays on/off (in seconds)

# Save current brightness
ORIGINAL=$(cat $LED)

# Function to flash LED
flash_led() {
    for i in $(seq 1 $FLASH_COUNT); do
        echo 255 | sudo tee $LED > /dev/null
        sleep $FLASH_DURATION
        echo 0 | sudo tee $LED > /dev/null
        sleep $FLASH_DURATION
    done
    # Restore original brightness
    echo $ORIGINAL | sudo tee $LED > /dev/null
}

echo "Monitoring GNOME notifications... Press Ctrl+C to stop"
echo "Current keyboard backlight: $ORIGINAL"
echo "Flash count: $FLASH_COUNT"

# Monitor D-Bus for GNOME notifications
dbus-monitor "interface='org.freedesktop.Notifications',member='Notify'" | 
while read -r line; do
    if echo "$line" | grep -q "string"; then
        # Update original brightness in case user changed it
        ORIGINAL=$(cat $LED)
        flash_led &
    fi
done