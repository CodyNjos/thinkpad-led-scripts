# ThinkPad LED Control Guide

**This guide is for Linux only.**

The `/sys/class/leds/` interface and `thinkpad_acpi` kernel driver are **Linux-specific**. 


## Viewing Available LEDs

To see all controllable LEDs on your ThinkPad:
```bash
ls /sys/class/leds/
```

This will list all available LEDs. On a ThinkPad X1 Carbon Gen 9, you'll see something like:
```
input3::capslock
input3::numlock
input3::scrolllock
phy0-led
platform::micmute
platform::mute
tpacpi::kbd_backlight
tpacpi::lid_logo_dot
tpacpi::power
tpacpi::standby
tpacpi::thinklight
tpacpi::thinkvantage
```

## Controlling an LED

Basic syntax:
```bash
echo [VALUE] | sudo tee /sys/class/leds/[LED_NAME]/brightness
```

Where:
- `[VALUE]` = brightness level (usually 0-255, but many LEDs only support 0=off, anything else=on)
- `[LED_NAME]` = the LED name from the list above

### Examples

Turn logo LED off:
```bash
echo 0 | sudo tee /sys/class/leds/tpacpi::lid_logo_dot/brightness
```

Turn logo LED on:
```bash
echo 255 | sudo tee /sys/class/leds/tpacpi::lid_logo_dot/brightness
```

Turn keyboard backlight off:
```bash
echo 0 | sudo tee /sys/class/leds/tpacpi::kbd_backlight/brightness
```

Set keyboard backlight to medium:
```bash
echo 128 | sudo tee /sys/class/leds/tpacpi::kbd_backlight/brightness
```

## Check Current Brightness
```bash
cat /sys/class/leds/[LED_NAME]/brightness
```

Example:
```bash
cat /sys/class/leds/tpacpi::lid_logo_dot/brightness
```

## Check Maximum Brightness

Some LEDs have a max_brightness value:
```bash
cat /sys/class/leds/[LED_NAME]/max_brightness
```

## Notes

- Most ThinkPad LEDs are **binary** (on/off only), not actually dimmable
- The keyboard backlight (`tpacpi::kbd_backlight`) usually supports multiple brightness levels
- You need `sudo` to control LEDs
- Press `Ctrl+C` to stop any running LED script
