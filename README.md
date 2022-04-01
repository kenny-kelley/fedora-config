# Setting up a fresh Fedora install
This repo contains configuration files and notes for a fresh install of Fedora.

This was done for the Server Edition of Fedora 35.

## Details about the installer
I don't think that keeping exact notes for the installation is all that important, so I will just hit the highlights.

I used the "Netinstall" ISO from here: https://getfedora.org/en/server/download/

This article has a good overview of the available options: https://docs.fedoraproject.org/en-US/fedora-server/server-installation/

### "Software Selection"
Most recently, I selected only "Fedora Server Edition". It is pretty barebones, but includes the web console thing.

### Installation Destination
I generally do default disk partitioning.

### Network & Host Name
Pay attention to the host name field in the network setup page. I always seem to miss that.

### Root Account
I enabled the `root` user account, but not for remote login.

### User Creation
I created my own user account with adminstrative privileges.

## Initial setup
Once SSHed or VNCed into the machine, we'll work on getting the basics covered.

### Update all the things
To update the existing packages, run:
```bash
sudo dnf check-update
sudo dnf upgrade
```

### Install GNOME
To install the GNOME desktop environment (DE), run:
```bash
sudo dnf install @gnome-desktop
```

### Install `vim`
For some reason, they don't include `vim` in the vanilla Server Edition install. Take care of that now:
```bash
sudo dnf install vim
```

### Setting up Remote Desktop Protocol (RDP)
To install `xrdp` (an open source implementation of RDP) and `xorgxrdp` (which lets `xrdp` directly use `X11`), run:
```bash
sudo dnf install xrdp
sudo dnf install xorgxrdp
```

We will need to tweak `/etc/xrdp/xrdp.ini` to get the `xorgxrdp` bit working:
- Uncomment the "[Xorg]" section
- Comment out the "[Xvnc]", "[vnc-any]", and "[neutrinordp-any]" sections (for good measure)

I also recommend backing up the original, default `xrdp.ini` file. See below:
```bash
sudo cp /etc/xrdp/xrdp.ini /etc/xrdp/xrdp.ini.backup
sudo vim /etc/xrdp/xrdp.ini # Make the above described edits
```

For reference, a copy of `xrdp.ini` is included in the root of this repository.

We likely need to enable and start `xrdp` as a system service:
```bash
sudo systemctl enable xrdp
sudo systemctl start xrdp
```

You can verify `xrdp` is running by calling:
```bash
sudo systemctl status xrdp
```

Lastly, we'll likely need to set up a firewall rule to allow RDP through:
```bash
sudo firewall-cmd --add-port=3389/tcp --permanent
sudo firewall-cmd --reload
```

You can check that that port is open by calling:
```bash
sudo firewall-cmd --list-ports
```

Now we should able to RDP in. "Xorg" should be the only option in the "Session" dropdown.

As an aside, I would maybe recommend checking that these things aren't already taken care of default before running any commands.

## Settling in to GNOME
Now that we're RDP-ed in, let's remove some bloat and install some good stuff.

### Removing bloat
There's a ton of shit that I uninstalled via GNOME's "Software" app (its GUI package manager).

Off the top of my head, I can only remember uninstalling these rip:
- Cheese
- GNOME Maps

### Installing the staples
```bash
sudo dnf install gnome-tweaks
sudo dnf install htop
sudo dnf install git
```

<!-- TODO: Notes on Plank, Sublime Text (be sure to reference the dotfiles repo), probably some other stuff -->
