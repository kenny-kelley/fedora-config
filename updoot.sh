#!/bin/bash -x
sudo dnf upgrade --refresh
sudo dnf autoremove
sudo akmods
sudo flatpak update
sudo flatpak uninstall --unused
flatpak update
flatpak uninstall --unused
