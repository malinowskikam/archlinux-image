#!/bin/sh

# $1 should be the username

# init pacman and upgrade system
pacman-key --init
pacman -Syu --noconfirm

#Generating password
PASSWORD=$(openssl rand -base64 16)
yes "$PASSWORD" | passwd "$1"
echo "Generated user password: $PASSWORD"

sleep infinity