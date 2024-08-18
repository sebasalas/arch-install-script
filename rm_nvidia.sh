#!/bin/bash

# Ensure the script is run as root
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root" >&2
    exit 1
fi

# Mount the file systems
mount /dev/sda2 /mnt
mount /dev/sda1 /mnt/boot

# Chroot into the new system and run the specified commands
arch-chroot /mnt /bin/bash <<EOF

# Remove NVIDIA drivers
pacman -Rns --noconfirm nvidia nvidia-utils nvidia-settings

# Remove existing Xorg configuration if any
rm -f /etc/X11/xorg.conf

# Regenerate initramfs
mkinitcpio -P

# Install nouveau driver
pacman -S --noconfirm xf86-video-nouveau

EOF

# Unmount all partitions
umount -R /mnt

# Reboot
reboot
