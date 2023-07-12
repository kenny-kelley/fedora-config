# How to set up Fedora Linux
These are notes taken while setting up my desktop's install of Fedora Linux 37 (Workstation Edition). These steps ought to work just fine on newer releases of Fedora.

## Updating software

### Upgrading `dnf` packages
To upgrade `dnf` packages (and remove any unused dependencies), run:
```bash
sudo dnf upgrade --refresh
sudo dnf autoremove
```

### Updating Flatpak applications and dependencies
To update Flatpak applications and dependencies (for the system and the current user), run:
```bash
sudo flatpak update
sudo flatpak uninstall --unused
flatpak update
flatpak uninstall --unused
```

### Updating device firmware
To update device firmware, run:
```bash
fwupdmgr refresh --force
fwupdmgr update
```

It's worth noting that, while not all that many devices are really supported via `fwupd`, it's worth running every once and a while (especially on newer systems).

Further help can be found here:
- https://wiki.archlinux.org/title/fwupd

## Adding software repositories

### Adding the RPM Fusion repositories for `dnf`
The RPM Fusion repositories contain some software that we'll need or want.

VLC, for example, is in the *free* repository. While the proprietary Nvidia drivers and Steam come out of the *nonfree* repository.

We can add the RPM Fusion free and nonfree repositories by installing these packages:
```bash
sudo dnf install \
    https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
    https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
```

After that finishes, we should update our local metadata cache:
```bash
sudo dnf makecache
```

As you install packages out of these repositories for the first time, you'll be prompted to verify the public key fingerprint. You can view those here:
- https://rpmfusion.org/keys

If you want applications from the RPM Fusion repositories to show up in GNOME Software, run:
```bash
sudo dnf groupupdate core
```

That should prompt for the install of two packages:
- `rpmfusion-free-appstream-data`
- `rpmfusion-nonfree-appstream-data`

See these links for additional help:
- https://rpmfusion.org/Configuration
- https://docs.fedoraproject.org/en-US/quick-docs/setup_rpmfusion/

### Adding the Flathub repository for Flatpak
To add and enable the Flathub repository for Flatpak, run:
```bash
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo flatpak remote-modify --enable flathub
```

Further help can be found here:
- https://flatpak.org/setup/Fedora


## Installing device drivers

### Installing the proprietary Nvidia drivers
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

## Installing new software

### Installing various staple programs
These are programs that I prefer to have around.

To install them, run:
```bash
sudo dnf install vim htop lm_sensors nvtop neofetch gnome-tweaks plank
```

*Plank* is a macOS-like dock. I always add it to the Startup Applications list in *GNOME Tweaks*.

### Installing the DejaVu fonts pack
You can install the DejaVu fonts pack (and refresh the font cache) like this:
```bash
sudo dnf install dejavu-fonts-all
fc-cache -v
```

### Installing Google Chrome
You'll need to enable the Google Chrome repository that Workstation Edition ships with. We can do that with `dnf config-manager`.

To install Google Chrome, run:
```bash
sudo dnf config-manager --set-enabled google-chrome
sudo dnf makecache
sudo dnf install google-chrome-stable
```

### Installing Steam
To install Steam, run:
```bash
sudo dnf install steam
```

Alternatively, you could probably find it in *GNOME Software*.

It's possible that `dnf` won't find this package. If that's the case, you may need to somehow tell `dnf` to look for 32-bit packages (the *i686* architecture).

### Installing Discord
To install Discord, run:
```bash
sudo flatpak install flathub com.discordapp.Discord
```

Alternatively, you could probably find it in *GNOME Software*.

Further help can be found here:
- https://flathub.org/apps/com.discordapp.Discord

### Installing Visual Studio Code
Just see this page for the most up to date way to install VS Code:
- https://code.visualstudio.com/docs/setup/linux


### Installing GIMP
To install GIMP, run:
```bash
sudo dnf install gimp
```

It'll have quite a few dependencies, so that's why I've included it separately.

### Installing VLC
This will be coming out of the RPM Fusion free repository.

To install VLC, run:
```bash
sudo dnf install vlc
```

It'll have quite a few dependencies, so that's why I've included it separately.

Further help can be found here:
- https://www.videolan.org/vlc/download-fedora.html

#### Getting `.mkv` and other video file thumbnails to work
This will also be coming out of the RPM Fusion free repository.

You should just have to install one package:
```bash
sudo dnf install ffmpegthumbnailer
```

If that doesn't do the trick on its own, consider deleting the contents of `~/.cache/thumbnails/`.

### Installing the Dolphin Emulator
To install the Dolphin Emulator for GameCube and Wii games, run:
```bash
sudo dnf install dolphin-emu
```

Further help can be found here:
- https://wiki.dolphin-emu.org/index.php?title=Installing_Dolphin

### Installing Spotify
To install Spotify, run:
```bash
sudo flatpak install flathub com.spotify.Client
```

Further help can be found here:
- https://flathub.org/apps/details/com.spotify.Client

### Installing Signal
To install Signal, run:
```bash
sudo flatpak install flathub org.signal.Signal
```

Further help can be found here:
- https://flathub.org/apps/details/org.signal.Signal

## Disabling the GRUB hidden menu feature
To disable the GRUB hidden menu feature, run:
```bash
sudo grub2-editenv - unset menu_auto_hide
```

Further help can be found here:
- https://fedoraproject.org/wiki/Changes/HiddenGrubMenu
- https://hansdegoede.livejournal.com/19081.html

## Fixing the GNOME login screen being on the wrong monitor
First, you'll need to log in with Wayland. Be sure to do this after installing the proprietary Nvidia drivers.

Then arrange the monitors to your liking via *GNOME Settings*.

Now, to fix the GNOME login screen being on the wrong monitor, run:
```bash
sudo cp ~/.config/monitors.xml /var/lib/gdm/.config/
sudo chown gdm:gdm /var/lib/gdm/.config/monitors.xml
```

You can see this effect immediately by pressing `Ctrl`+`Alt`+`F1`.

GNOME Display Manager will just ignore the file if anything is wrong with it. So, for every new monitor configuration, you'll need to do this again.

## Increasing the number of old kernels to keep installed
To increase the number of old kernels to keep installed, run:
```bash
sudo dnf config-manager --setopt=installonly_limit=4 --save
```

This will modify `/etc/dnf/dnf.conf`. To check that your changes took effect, run:
```bash
cat /etc/dnf/dnf.conf
```

By default, it would have been set to 3. I prefer to keep more than that around.

## Automatically signing the Nvidia driver kernel modules so that Secure Boot can be enabled
I am pretty sure that this is the only command that you need to run:
```bash
sudo mokutil --import /etc/pki/akmods/certs/public_key.der
```

That key should already exist on a fresh install of Fedora.

It'll ask you to put in a password, which you'll need to put in after a reboot.

Further help can be found here:
- https://blog.monosoul.dev/2022/05/17/automatically-sign-nvidia-kernel-module-in-fedora-36/
- https://gist.github.com/lijikun/22be09ec9b178e745758a29c7a147cc9
- https://github.com/dell/dkms#secure-boot
- https://download.nvidia.com/XFree86/Linux-x86/361.45.11/README/installdriver.html
