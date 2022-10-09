#!/bin/bash

echo "Running \`sudo dnf upgrade --refresh\`:"
sudo dnf upgrade --refresh

echo "Running \`dnf autoremove\`:"
sudo dnf autoremove

echo "Runnng \`sudo flatpak update\`:"
sudo flatpak update

echo "Runnng \`sudo flatpak uninstall --unused\`:"
sudo flatpak uninstall --unused
