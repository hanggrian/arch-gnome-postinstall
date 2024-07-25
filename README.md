# Arch GNOME Post-Install

Shell scripts to install popular packages and configure GNOME desktop
environment on Arch Linux. The scripts prefer DKMS drivers over standard
drivers when available. When presented with options of GUI applications, the
scripts will install GTK over Qt-based applications.

## Installation

Change file permissions to make the script executable:

```sh
chmod -R +x "$PATH_TO_SCRIPTS/arch-gnome-postinstall"
```
