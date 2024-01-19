# Notes specific to my MacBook Pro
I run Fedora on my 13-inch, Late 2011 MacBook Pro. These are the things I do to make it work well.

## Making the touchpad not suck
This is assuming you're using Wayland.

First, install some `libinput` utilities to help us verify what's going on:
```bash
sudo dnf install libinput-utils
```

This will let us run `libinput quirks`.

Now, let's fine the device that's the touchpad:
```bash
sudo libinput list-devices
```

Mine ended up being `/dev/input/event9`, which can be seen here:
```
Device:           bcm5974
Kernel:           /dev/input/event9
Group:            6
Seat:             seat0, default
Size:             107x75mm
Capabilities:     pointer gesture
Tap-to-click:     disabled
Tap-and-drag:     enabled
Tap drag lock:    disabled
Left-handed:      disabled
Nat.scrolling:    enabled
Middle emulation: disabled
Calibration:      n/a
Scroll methods:   *two-finger edge 
Click methods:    button-areas *clickfinger 
Disable-w-typing: enabled
Disable-w-trackpointing: enabled
Accel profiles:   flat *adaptive custom
Rotation:         n/a
```

Now we can run this to see what quirks are applied:
```bash
libinput quirks list --verbose /dev/input/event9
```

The tail end of it looked like this:
```
ModelAppleTouchpad=1
AttrSizeHint=104x75
AttrTouchSizeRange=150:130
AttrPalmSizeThreshold=800
```

The main culprit of the touchpad not working well is the `AttrPalmSizeThreshold=800`. We want to set that number to be bigger.

Filter it down to the full matches:
```
kenny@GLaDOS-PC:~$ libinput quirks list --verbose /dev/input/event9 | grep "is full match"
quirks debug: [Apple Touchpads USB] (50-system-apple.quirks) is full match
```

Now that's that's confirmed, we can set some local override quirks.

Make a directory at `/etc/libinput`:
```bash
sudo mkdir /etc/libinput
```

Now add this stuff to a file at `/etc/libinput/local-overrides.quirks`:
```
[Apple Touchpads USB]
MatchVendor=0x05AC
MatchBus=usb
MatchUdevType=touchpad
ModelAppleTouchpad=1
AttrSizeHint=104x75
AttrTouchSizeRange=150:130
AttrPalmSizeThreshold=3200
```

These are based the `[Apple Touchpads USB]` section of the `/usr/share/libinput/50-system-apple.quirks` INI file. The only change (as of writing) is `AttrPalmSizeThreshold=3200`.

You can run `libinput quirks list --verbose /dev/input/event9 | grep "is full match"` and `libinput quirks list --verbose /dev/input/event9 | tail` to see that things are looking good.

Log out and log back in to actually have the changes take effect.

These were the main sources that helped me arrive at this solution:
- https://www.sharpwriting.net/project/libinput-on-old-macbooks/
- https://wayland.freedesktop.org/libinput/doc/latest/device-quirks.html
- https://askubuntu.com/questions/1387482/ubuntu-on-2012-macbook-pro-pointer-stops-when-extra-pressure-is-applied-to-tou
