# Arch Linux Installation Script

## Overview
This script automates the installation of Arch Linux with a specific set of configurations. It sets up a GPT partitioning scheme, formats the partitions, installs a basic set of packages including GNOME desktop and necessary system utilities, and performs basic system configuration. 

## Features
- Automated disk partitioning.
- System clock synchronization.
- File system creation and mounting.
- Base system installation via `pacstrap`.
- System configuration inside `chroot` including:
  - Locale setting.
  - Timezone setting.
  - Network configuration.
  - Hostname and user setup.
  - Bootloader installation.

## Prerequisites
To use this script, you need:
- A bootable Arch Linux installation media.
- An active internet connection during the installation.

## Usage
1. Boot your system using the Arch Linux installation media.
2. Ensure your system is connected to the internet.
3. Download the script using:
   ```bash
   curl -O https://raw.githubusercontent.com/sebasalas/arch-installation-script/main/arch_install.sh
