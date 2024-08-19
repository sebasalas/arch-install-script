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
pacman -Rns --noconfirm nvidia || true
pacman -Rns --noconfirm nvidia-utils || true
pacman -Rns --noconfirm nvidia-settings || true
pacman -Rns --noconfirm nvidia-dkms || true

# Remove existing Xorg configuration if any
rm -f /etc/X11/xorg.conf

# Remove blacklist-nouveau if any
rm -f /etc/modprobe.d/blacklist-nouveau.conf
rm -f /etc/modprobe.d/nouveau.conf

# Remove nvidia modprobe if any
rm -f /etc/modprobe.d/nvidia.conf

cp /etc/environment.bak /etc/environment

# Regenerate initramfs
cp /etc/mkinitcpio.bak /etc/mkinitcpio.conf
mkinitcpio -P

# Regenerate GRUB
cp /etc/default/grub.bak /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg

# Install nouveau driver
pacman -S --noconfirm xf86-video-nouveau

EOF

# Unmount all partitions
umount -R /mnt

# Reboot
reboot
