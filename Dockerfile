FROM archlinux:latest

ARG LOCALE=en_US.UTF-8
ARG TIMEZONE=/usr/share/zoneinfo/Europe/Warsaw
ARG HOSTNAME=arch
ARG USERNAME=user

# Upgrade and install basic tools
RUN pacman -Syu --noconfirm bash git openssh neovim tmux sudo rsync jq less curl wget neofetch man-db man-pages 

# Create user
RUN useradd -m -G wheel -s /bin/bash $USERNAME

# Allow sudo with user password
RUN sed -i 's/# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/g' /etc/sudoers

# Start SSHD
RUN ssh-keygen -A
RUN /usr/sbin/sshd

#Setting time
RUN ln -sf $TIMEZONE /etc/localtime
RUN hwclock --systohc

#Setting locale
RUN sed -i "s/#$LOCALE/$LOCALE/g" /etc/locale.gen
RUN locale-gen
RUN echo "LANG=$LOCALE" > /etc/locale.conf

#Setting hostname
RUN echo "$HOSTNAME" > /etc/hostname

COPY entrypoint.sh /entrypoint.sh

CMD ["/entrypoint.sh", "$USER"]