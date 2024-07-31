# Bluefin derivied - Modified for me.

This has bluefix-dx and aurora-dx modified to include software for me.
* Hyprland, Waybar, Kitty, Alacritty
My favourite programming fonts. Fira-code.

# Installation instructions
Download the bluefin or aurora iso. Follow the installation instructions.

## Options for the commands below.
Images - bluefin-dx or aurora-dx
Versions - latest, stable or gts (bluefin-dx only)

Change the commands below to switch between the images and versions.

Next run the following command
```bash
rpm-ostree rebase ostree-unverified-image:docker://ghcr.io/garrickwelsh/bluefin-dx:latest
```
Once completed reboot. Then run.
```bash
rpm-ostree rebase ostree-image-signed:docker://ghcr.io/garrickwelsh/bluefin-dx:latest
```
Reboot and the installation is finished.

## Bluefin - [projectbluefin.io](https://projectbluefin.io)

![image](https://github.com/ublue-os/bluefin/assets/1264109/b093bdec-40dc-48d2-b8ff-fcf0df390e8c)

> "Evolution is a process of constant branching and expansion." - Stephen Jay Gould

Bluefin strives to cover these two use cases. For end users it provides a system as reliable as a Chromebook with near-zero maintainance, with the power of homebrew, flathub, and a container runtime to give you access to all the best software Open Source has to offer. Check [Introduction to Bluefin](https://universal-blue.discourse.group/t/introduction-to-bluefin/41) for a feature walkthrough. 

- [Download Bluefin](https://projectbluefin.io/#scene-picker)

## Aurora - [getaurora.dev](https://getaurora.dev)

[![aurora 39](https://github.com/ublue-os/bluefin/actions/workflows/build-39-aurora.yml/badge.svg)](https://github.com/ublue-os/bluefin/actions/workflows/build-39-aurora.yml) [![aurora 40](https://github.com/ublue-os/bluefin/actions/workflows/build-40-aurora.yml/badge.svg)](https://github.com/ublue-os/bluefin/actions/workflows/build-40-aurora.yml)

![Screenshot_20240423_211805](https://github.com/ublue-os/bluefin/assets/40402114/1bea1ed8-d97a-402a-957b-e0f338d38230)

Aurora is a delightful KDE desktop experience for end-users that are looking for reliability and developers for the most-hassle free setup. Zero maintenance included.

- [Download Aurora](https://getaurora.dev)

