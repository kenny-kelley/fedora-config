# How to set up Fedora Linux
These are notes taken while setting up my desktop's install of Fedora Linux 37 (Workstation Edition).

## The first thing you should do
Be sure to upgrade any packages via `dnf`:
```bash
sudo dnf upgrade --refresh
sudo dnf autoremove
```

Doing this pair of commands throughout your setup process could be a good idea. Be sure to do it at least once more at the very end.

## Installing various staple programs
These are things we're going to want right off the bat.

Install the following:
```bash
sudo dnf install vim tmux htop neofetch gnome-tweaks plank
```

## Adding the RPM Fusion nonfree repository
The RPM Fusion repositories contain some software that we'll need or want. In particular we need to add their *nonfree* repository.

We can add RPM Fusion nonfree repository by installing this package:
```bash
sudo dnf install https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
```

After that finishes, we should update our local metadata cache:
```bash
sudo dnf makecache
```

Now we should be able to install the properietary Nvidia drivers, Steam, and Discord.

See these links for additional help:
- https://rpmfusion.org/Configuration
- https://docs.fedoraproject.org/en-US/quick-docs/setup_rpmfusion/

## Installing the properietary Nvidia drivers
Install these packages via `dnf`:
```bash
sudo dnf install akmod-nvidia
sudo dnf install xorg-x11-drv-nvidia-cuda
```

The `xorg-x11-drv-nvidia-cuda` package, which includes CUDA and some video encoder support, is technically optional, but I recommend it.

After a reboot, remove the *nouveau* drivers for good measure:
```bash
sudo dnf remove xorg-x11-drv-nouveau
sudo dnf autoremove
```

I would reboot again too, out of paranoia.

Further help can be found here:
- https://rpmfusion.org/Howto/NVIDIA

## Installing Steam
To install Steam, run:
```bash
sudo dnf install steam
```

Alternatively, you could probably find it in *GNOME Software*

It's possible that `dnf` won't find this package. If that's the case, you may need to somehow tell `dnf` to look for 32-bit packages (the *i686* architecture).

## Installing Discord
To install Discord, run:
```bash
sudo dnf install discord
```

Alternatively, you could probably find it in *GNOME Software*.

## Installing the DejaVu fonts pack
You can install the DejaVu fonts pack (and refresh the font cache) like this:
```bash
sudo dnf install dejavu-fonts-all
fc-cache -v
```

## Installing Google Chrome
You'll need to enable the Google Chrome repository that Workstation Edition ships with. We can do that with `dnf config-manager`.

To install Google Chrome, run:
```bash
sudo dnf config-manager --set-enabled google-chrome
sudo dnf makecache
sudo dnf install google-chrome-stable
```

## Adding the Flathub repository for Flatpak
To add the Flathub repository for Flatpak, run:
```bash
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
```

Further help can be found here:
- https://flatpak.org/setup/Fedora

## Installing Spotify
To install Spotify, run:
```bash
sudo flatpak install flathub com.spotify.Client
```

Further help can be found here:
- https://flathub.org/apps/details/com.spotify.Client

## Installing Signal
To install Signal, run:
```bash
sudo flatpak install flathub org.signal.Signal
```

Further help can be found here:
- https://flathub.org/apps/details/org.signal.Signal

## Fixing a humming/hissing noise when no audio is playing
Create a file in `/etc/modprobe.d/`:
```bash
sudo vim /etc/modprobe.d/snd_hda_intel_power_save.conf # Make your edits
```

Include the following content:
```
options snd_hda_intel power_save=0 power_save_controller=N
```

The default permissions from `sudo vim` should be fine.

Reboot the machine.
