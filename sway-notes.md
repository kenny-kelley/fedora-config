# Setting up Sway
To install `sway`, do this:
```bash
sudo dnf install @sway-desktop-environment
```

This package group brings a fair few things that I decided I was okay starting with. Installing the `sway` package on its own would probably be okay and pretty good.

## Installing `fuzzel`
`fuzzel` is the application launcher I use to replace `dmenu`:
```bash
sudo dnf install fuzzel
```

## A dark theme for Qt applications
On GNOME, Qt (6?) applications (such as Wireshark) seem to pick up some sort of dark theme. On Sway, they don't.

So install this package:
```bash
sudo install adwaita-qt6
```

And then you'll need to set `QT_STYLE_OVERRIDE=adwaita-dark` somewhere (such as when calling `fuzzle`).
