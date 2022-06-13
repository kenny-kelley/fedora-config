# Fedora setup notes for desktop PC
These are notes taken while setting up my desktop's install of Fedora Linux 36 (Workstation Edition). 

## Installing various staple programs
Install the following:
```bash
sudo dnf install vim htop plank gnome-tweaks
```

## DejaVu fonts
You can install the DejaVu fonts like this:
```bash
sudo dnf install dejavu-fonts-all
fc-cache -v
```

## Installing Nvidia graphics drivers
First, you'll need to enable the Nvidia driver repository. I like to do this via Fedora's `Software` GUI package manager thing.

You can then install the drivers:
```bash
sudo dnf install akmod-nvidia
sudo dnf install xorg-x11-drv-nvidia-cuda
```

After a reboot, remove the `nouveau` drivers for good measure:
```bash
sudo dnf remove xorg-x11-drv-nouveau
```

I would reboot again too, out of paranoia.

## Installing Google Chrome
First, you'll need to enable the Google Chrome repository. Once again, I like to do this via Fedora's `Software` application.

Then run:
```bash
sudo dnf install google-chrome-stable
```

## Installing Steam
First, you'll need to enable the Steam repository. Once again, I like to do this via Fedora's `Software` application.

Then run:
```bash
sudo dnf install steam
```

## Installing Discord
Run this stuff:
```bash
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install discord
```

## Installing Spotify
Run this stuff:
```bash
flatpak install spotify
```
