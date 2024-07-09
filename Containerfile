
ARG IMAGE_NAME="${IMAGE_NAME}"
ARG IMAGE_VENDOR="${IMAGE_VENDOR}"
ARG BASE_IMAGE_NAME="${BASE_IMAGE_NAME}"
ARG IMAGE_FLAVOR="${IMAGE_FLAVOR}"
ARG AKMODS_FLAVOR="${AKMODS_FLAVOR}"
ARG FEDORA_MAJOR_VERSION="${FEDORA_MAJOR_VERSION}"
ARG COREOS_TYPE="${COREOS_TYPE:-}"
ARG KERNEL="${KERNEL:-}"
ARG UBLUE_IMAGE_TAG="${UBLUE_IMAGE_TAG:-latest}"

## bluefin image section
FROM ghcr.io/ublue-os/${BASE_IMAGE_NAME}:${FEDORA_MAJOR_VERSION} AS base

## bluefin-dx developer edition image section
FROM base AS dx

# Build, Clean-up, Commit
RUN rpm-ostree install alacritty kitty helix neovim fira-code-fonts && \
    rpm-ostree install hyprland waybar swaybg wofi grim slurp swaylock pipewire pipewire-pulseaudio pipewire-utils pulseaudio-utils && \
    ostree container commit && \
    mkdir -p /var/tmp && \
    chmod -R 1777 /var/tmp
