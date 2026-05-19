#!/bin/bash
set -euo pipefail

# ============================================================
# LIGHTOS - Build Script
# Fedora Bootc 42 + Nvidia + Hyprland + Gaming + Dev + Multimedia
# ============================================================

echo "========================================="
echo "  LIGHTOS - Inizio build"
echo "========================================="

# ──────────────────────────────────────────────
# 1. REPOSITORIES
# ──────────────────────────────────────────────
echo ">>> Configurazione repository..."

# RPM Fusion (free + nonfree)
dnf install -y \
    https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
    https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# Hyprland COPR repo
dnf copr enable -y solopasha/hyprland || true

# Aggiorna cache dopo nuovi repo
dnf makecache

# ──────────────────────────────────────────────
# 2. NVIDIA DRIVERS (proprietari)
# ──────────────────────────────────────────────
echo ">>> Installazione driver Nvidia..."

dnf install -y \
    akmod-nvidia \
    xorg-x11-drv-nvidia \
    xorg-x11-drv-nvidia-cuda \
    xorg-x11-drv-nvidia-cuda-libs \
    xorg-x11-drv-nvidia-libs \
    nvidia-settings \
    nvidia-gpu-firmware \
    nvidia-container-toolkit \
    nvidia-persistenced

systemctl enable nvidia-persistenced.service

# ──────────────────────────────────────────────
# 3. HYPRLAND & TILING WM ECOSYSTEM
# ──────────────────────────────────────────────
echo ">>> Installazione Hyprland e Tiling WM..."

dnf install -y \
    hyprland \
    hyprpaper \
    hyprlock \
    hypridle \
    hyprpicker \
    hyprsunset \
    xdg-desktop-portal-hyprland \
    xdg-desktop-portal-gtk \
    waybar \
    rofi-wayland \
    dunst \
    mako \
    fuzzel \
    wlogout \
    grim \
    slurp \
    wl-clipboard \
    wtype \
    wlr-randr \
    kanshi \
    swaybg \
    swaylock \
    swayidle \
    foot \
    alacritty \
    kitty || true

# ──────────────────────────────────────────────
# 4. GAMING
# ──────────────────────────────────────────────
echo ">>> Installazione pacchetti Gaming..."

dnf install -y \
    steam \
    wine \
    wine-core \
    wine-mono \
    winetricks \
    gamemode \
    gamescope \
    mangohud \
    vkBasalt \
    protontricks \
    lutris \
    retroarch \
    retroarch-assets \
    ppsspp \
    pcsx2 \
    dolphin-emu \
    mupen64plus \
    xpad \
    xboxdrv \
    steam-devices || true

# ──────────────────────────────────────────────
# 5. DEVELOPMENT TOOLS
# ──────────────────────────────────────────────
echo ">>> Installazione Development Tools..."

dnf install -y \
    git \
    git-lfs \
    vim \
    neovim \
    helix \
    tmux \
    zsh \
    fish \
    fzf \
    ripgrep \
    fd-find \
    bat \
    eza \
    zoxide \
    starship \
    jq \
    yq \
    htop \
    btop \
    fastfetch \
    tree \
    unzip \
    p7zip \
    curl \
    wget \
    httpie \
    just \
    make \
    cmake \
    gcc \
    gcc-c++ \
    gdb \
    rust \
    cargo \
    golang \
    nodejs \
    npm \
    python3 \
    python3-pip \
    python3-virtualenv \
    podman \
    podman-compose \
    buildah \
    skopeo \
    distrobox \
    toolbox \
    code \
    flatpak-builder || true

# ──────────────────────────────────────────────
# 6. MULTIMEDIA & CODECS
# ──────────────────────────────────────────────
echo ">>> Installazione Multimedia e Codecs..."

dnf install -y \
    gstreamer1 \
    gstreamer1-plugins-base \
    gstreamer1-plugins-good \
    gstreamer1-plugins-bad-free \
    gstreamer1-plugins-ugly-free \
    gstreamer1-plugins-ugly \
    gstreamer1-plugin-libav \
    gstreamer1-plugin-openh264 \
    ffmpeg \
    ffmpeg-libs \
    libva \
    libva-intel-driver \
    libva-nvidia-driver \
    mesa-dri-drivers \
    mesa-vulkan-drivers \
    vulkan-tools \
    vulkan-loader \
    libvdpau \
    pipewire \
    pipewire-alsa \
    pipewire-pulseaudio \
    pipewire-jack-audio-connection-kit \
    wireplumber \
    pavucontrol \
    easyeffects \
    helvum \
    obs-studio \
    vlc \
    mpv \
    gimp \
    inkscape \
    kdenlive \
    audacity \
    blender \
    darktable \
    shotwell || true

# ──────────────────────────────────────────────
# 7. PRODUTTIVITÀ & OFFICE
# ──────────────────────────────────────────────
echo ">>> Installazione Produttività..."

dnf install -y \
    libreoffice \
    libreoffice-langpack-it \
    thunderbird \
    keepassxc \
    nextcloud-client \
    syncthing \
    foliate \
    evince \
    file-roller \
    gnome-calculator \
    gnome-calendar \
    gnome-clocks \
    gnome-screenshot \
    gnome-tweaks \
    dconf-editor \
    gparted \
    baobab || true

# ──────────────────────────────────────────────
# 8. INTERNET & COMUNICAZIONE
# ──────────────────────────────────────────────
echo ">>> Installazione Internet e Comunicazione..."

dnf install -y \
    firefox \
    chromium \
    transmission \
    remmina \
    filezilla || true

# ──────────────────────────────────────────────
# 9. SISTEMA & UTILITÀ (flatpak incluso qui)
# ──────────────────────────────────────────────
echo ">>> Installazione Sistema e Utilità..."

dnf install -y \
    NetworkManager \
    NetworkManager-wifi \
    NetworkManager-bluetooth \
    bluez \
    blueman \
    firewalld \
    ufw \
    chrony \
    dnf-automatic \
    rpmconf \
    flatpak \
    snapd \
    fwupd \
    tlp \
    tlp-rdw \
    power-profiles-daemon \
    thermald \
    smartmontools \
    nvme-cli \
    usbutils \
    pciutils \
    lshw \
    inotify-tools \
    xdg-user-dirs \
    xdg-utils \
    polkit \
    dbus-tools \
    systemd-container \
    systemd-networkd || true

# Abilita servizi di sistema
systemctl enable \
    dnf-automatic-install.timer \
    fstrim.timer \
    bluetooth.service \
    firewalld.service \
    chronyd.service \
    tlp.service \
    thermald.service \
    fwupd.service \
    snapd.socket \
    snapd.service 2>/dev/null || true

# ──────────────────────────────────────────────
# 10. FONTS
# ──────────────────────────────────────────────
echo ">>> Installazione Fonts..."

dnf install -y \
    jetbrains-mono-fonts \
    fira-code-fonts \
    cascadia-code-fonts \
    fontawesome-fonts \
    fontawesome-fonts-web \
    google-noto-sans-fonts \
    google-noto-sans-mono-fonts \
    google-noto-serif-fonts \
    google-noto-emoji-fonts \
    liberation-fonts \
    dejavu-sans-fonts \
    dejavu-sans-mono-fonts \
    dejavu-serif-fonts || true

# ──────────────────────────────────────────────
# 11. FLATKUB + FLATPAK APPS
# ──────────────────────────────────────────────
echo ">>> Configurazione Flathub e Flatpak apps..."

flatpak remote-add --if-not-exists --system flathub https://dl.flathub.org/repo/flathub.flatpakrepo 2>/dev/null || true

flatpak install -y --system flathub \
    com.discordapp.Discord \
    com.spotify.Client \
    com.heroicgameslauncher.hgl \
    net.davidotek.pupgui2 \
    com.github.tchx84.Flatseal \
    org.gnome.Extensions \
    com.mattjakeman.ExtensionManager \
    org.localsend.localsend_app \
    io.github.flattool.Warehouse \
    io.missioncenter.MissionCenter \
    com.github.wwmm.easyeffects \
    org.freedesktop.Platform.ffmpeg-full//24.08 \
    org.freedesktop.Platform.GL.nvidia-*/24.08 2>/dev/null || true

# ──────────────────────────────────────────────
# 12. CONFIGURAZIONI FINALI
# ──────────────────────────────────────────────
echo ">>> Applicazione configurazioni..."

systemctl enable akmods.service 2>/dev/null || true
usermod -aG gamemode root 2>/dev/null || true

# ──────────────────────────────────────────────
# 13. PULIZIA
# ──────────────────────────────────────────────
echo ">>> Pulizia..."

dnf clean all
rm -rf /var/cache/dnf /tmp/* /var/tmp/*

echo "========================================="
echo "  LIGHTOS - Build completata!"
echo "========================================="
