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

## Fixing a humming/hissing noise when no audio is playing
Create a file in `/etc/modprobe.d/`:
```bash
sudo vim /etc/modprobe.d/snd_hda_intel_power_save.conf # Make your edits
```

Include the following content:
```bash
options snd_hda_intel power_save=0 power_save_controller=N
```

The default permissions from `sudo vim` should be fine.

Reboot the machine.
