
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

RUN wget "https://copr.fedorainfracloud.org/coprs/ryanabx/cosmic-epoch/repo/fedora-$(rpm -E %fedora)/ryanabx-cosmic-epoch-fedora-$(rpm -E %fedora).repo" -O /etc/yum.repos.d/_copr_ryanabx-cosmic.repo \
    && CHEZMOI_VERSION=$(curl -s "https://api.github.com/repos/twpayne/chezmoi/releases/latest" | jq -r .tag_name | \grep -Po 'v\K[^"]*') \
    # No longer testing the Zed Editor leave for the moment.
    # && curl -fsSL https://github.com/terrapkg/subatomic-repos/raw/main/terra.repo | tee /etc/yum.repos.d/terra.repo \
    && rpm-ostree install cosmic-desktop \
      alacritty kitty helix neovim fira-code-fonts \
      hyprland waybar swaybg wofi grim slurp swaylock \
      dunst pipewire pipewire-pulseaudio pipewire-utils pulseaudio-utils \
      tealdeer \
      NetworkManager-tui \
      rsync \
      spice-gtk-tools \
      # zed \
      gh \
      https://github.com/twpayne/chezmoi/releases/download/v${CHEZMOI_VERSION}/chezmoi-${CHEZMOI_VERSION}-x86_64.rpm \
      niri xwayland-satellite \
  # Install helix to get the latest version
  && HELIX_VERSION=$(curl -s "https://api.github.com/repos/helix-editor/helix/releases/latest" | jq -r .tag_name) \
  && curl -Lo helix-${HELIX_VERSION}-x86_64-linux.tar.xz https://github.com/helix-editor/helix/releases/download/${HELIX_VERSION}/helix-${HELIX_VERSION}-x86_64-linux.tar.xz \
  && tar Jxf helix-${HELIX_VERSION}-x86_64-linux.tar.xz \
  && cd helix-${HELIX_VERSION}-x86_64-linux \
  && install -Dm755 -t "/usr/bin" hx \
  && mv runtime "/usr/bin" \
  && install -Dm644 -T contrib/completion/hx.bash "/usr/share/bash-completion/completions/hx" \
  && install -Dm644 -T contrib/completion/hx.fish "/usr/share/fish/vendor_completions.d/hx.fish" \
  && install -Dm644 -T contrib/completion/hx.zsh "/usr/share/zsh/site-functions/_hx" \
  && cd .. \
  && rm -r helix-${HELIX_VERSION}-x86_64-linux \
  && rm helix-${HELIX_VERSION}-x86_64-linux.tar.xz \
  && ostree container commit \
  && mkdir -p /var/tmp \
  && chmod -R 1777 /var/tmp 

RUN if [[ -f /usr/share/xdg-desktop-portal/portals/gnome-keyring.portal ]]; then \
      echo -e ";\norg.freedesktop.impl.portal.Secret=gnome-keyring;\n" >> /usr/share/xdg-desktop-portal/hyprland-portals.conf ; \
      cp /usr/share/xdg-desktop-portal/portals/gnome-keyring.portal /usr/share/xdg-desktop-portal/portals/gnome-keyring.portal.tmp ; \
      cat /usr/share/xdg-desktop-portal/portals/gnome-keyring.portal.tmp | sed "s/gnome/gnome;hyprland/" > /usr/share/xdg-desktop-portal/portals/gnome-keyring.portal ; \
      rm /usr/share/xdg-desktop-portal/portals/gnome-keyring.portal.tmp ; \
    fi
    # rpm-ostree install terra-release && \
