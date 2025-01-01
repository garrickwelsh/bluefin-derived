
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
## bluefin-dx developer edition image section
FROM ghcr.io/ublue-os/${BASE_IMAGE_NAME}:${FEDORA_MAJOR_VERSION} AS dx

# WORKDIR "/usr/local/bin"

RUN wget "https://copr.fedorainfracloud.org/coprs/ryanabx/cosmic-epoch/repo/fedora-$(rpm -E %fedora)/ryanabx-cosmic-epoch-fedora-$(rpm -E %fedora).repo" -O /etc/yum.repos.d/_copr_ryanabx-cosmic.repo && \
    CHEZMOI_VERSION=$(curl -s "https://api.github.com/repos/twpayne/chezmoi/releases/latest" | jq -r .tag_name | \grep -Po 'v\K[^"]*') && \
    curl -fsSL https://github.com/terrapkg/subatomic-repos/raw/main/terra.repo | tee /etc/yum.repos.d/terra.repo && \
    rpm-ostree install cosmic-desktop \
      alacritty kitty helix neovim fira-code-fonts \
      hyprland waybar swaybg wofi grim slurp swaylock \
      dunst pipewire pipewire-pulseaudio pipewire-utils pulseaudio-utils \
      tealdeer \
      NetworkManager-tui \
      zed \
      https://github.com/twpayne/chezmoi/releases/download/v${CHEZMOI_VERSION}/chezmoi-${CHEZMOI_VERSION}-x86_64.rpm && \
    ostree container commit && \
    mkdir -p /var/tmp && \
    chmod -R 1777 /var/tmp && \
    echo -e ";\norg.freedesktop.impl.portal.Secret=gnome-keyring;\n" >> /usr/share/xdg-desktop-portal/hyprland-portals.conf && \
    cp /usr/share/xdg-desktop-portal/portals/gnome-keyring.portal /usr/share/xdg-desktop-portal/portals/gnome-keyring.portal.tmp && \
    cat /usr/share/xdg-desktop-portal/portals/gnome-keyring.portal.tmp | sed "s/gnome/gnome;hyprland/" > /usr/share/xdg-desktop-portal/portals/gnome-keyring.portal && \
    rm /usr/share/xdg-desktop-portal/portals/gnome-keyring.portal.tmp
    # rpm-ostree install terra-release && \
