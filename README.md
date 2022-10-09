# Fedora setup notes for desktop PC
These are notes taken while setting up my desktop's install of Fedora Linux 36 (Workstation Edition). 

## Initial setup
After getting signed in, be sure to update any packages via `dnf`:
```bash
sudo dnf upgrade --refresh
sudo dnf autoremove
```

Doing this pair of commands throughout your setup process could be a good idea. (At least do it once more at the end.)

## Installing various staple programs
These are things we're going to want right off the bat.

Install the following:
```bash
sudo dnf install vim htop plank gnome-tweaks
```

## DejaVu fonts
You can install the DejaVu fonts (and refresh the font cache) like this:
```bash
sudo dnf install dejavu-fonts-all
fc-cache -v
```

## Enabling the RPM Fusion nonfree repository
The RPM Fusion repositories contain some software that we'll need or want. In particular we need to add their *nonfree* repository.

We can add RPM Fusion nonfree repository by installing this package:
```bash
sudo dnf install https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
```

After that finishes, we should update our local metadata cache:
```bash
sudo dnf makecache
```

Now we should be able to install the Nvidia drivers and Discord.

See these links for additional help:
- https://docs.fedoraproject.org/en-US/quick-docs/setup_rpmfusion/
- https://rpmfusion.org/Configuration

### About Third-Party Repositories
It might be worth noting that Fedora has a "Third-Party Repositories" feature than can be managed via the GNOME `Software` GUI package manager and `dnf config-manager`.

Here are Fedora's docs on them:
- https://docs.fedoraproject.org/en-US/workstation-working-group/third-party-repos/

We'll use this mechanism for a few things, but not the RPM Fusion nonfree repo.

## Installing Nvidia graphics drivers
Install these packages via `dnf`:
```bash
sudo dnf install akmod-nvidia
sudo dnf install xorg-x11-drv-nvidia-cuda
```

These should come out of the `rpmfusion-nonfree-updates` repository.

After a reboot, remove the `nouveau` drivers for good measure:
```bash
sudo dnf remove xorg-x11-drv-nouveau
sudo dnf autoremove
```

I would reboot again too, out of paranoia.

## Installing Google Chrome
First, you'll need to enable the Google Chrome repository. We can do that with `dnf config-manager`.

So run:
```bash
sudo dnf config-manager --set-enabled google-chrome
sudo dnf makecache
sudo dnf install google-chrome-stable
```

## Installing Steam
Since Steam isn't in the normal RPM Fusion nonfree repo, we'll have to add it separately with `dnf config-manager`.

So run:
```bash
sudo dnf config-manager --set-enabled rpmfusion-nonfree-steam
sudo dnf makecache
sudo dnf install steam
```

## Installing Discord
Run:
```bash
sudo dnf install discord
```

This should come out of the `rpmfusion-nonfree-updates` repository.

## Installing Spotify
Run this stuff:
```bash
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo flatpak install flathub com.spotify.Client
```

Further help can be found here:
- https://docs.fedoraproject.org/en-US/quick-docs/installing-spotify/
- https://flathub.org/apps/details/com.spotify.Client

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
