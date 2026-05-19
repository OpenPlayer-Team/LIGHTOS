# LIGHTOS ✨

Immagine bootc personalizzata basata su **Fedora Atomic** con focus su **Gaming**, **Sviluppo** e **Produttività**.

![License](https://img.shields.io/badge/license-Apache%202.0-blue)
![Base](https://img.shields.io/badge/base--Fedora%20Bootc%2042-green)
![Desktop](https://img.shields.io/badge/desktop-Hyprland-8a2be2)

## Caratteristiche

| Categoria | Dettagli |
|-----------|----------|
| **Base** | Fedora Bootc 42 |
| **Desktop** | Hyprland (Wayland tiling compositor) |
| **GPU** | Driver Nvidia proprietari + CUDA + NVENC |
| **Gaming** | Steam, Lutris, Wine/Proton, GameScope, MangoHud, emulazione |
| **Sviluppo** | Rust, Go, Node.js, Python, Docker/Podman, distrobox, VS Code |
| **Multimedia** | OBS, Kdenlive, GIMP, Blender, codec completi |
| **Produttività** | LibreOffice, Thunderbird, Flatpak apps |
| **Signing** | Container signing via cosign/Sigstore |

## Pacchetti principali

### Tiling WM / Desktop
`Hyprland` `Waybar` `Rofi` `Dunst` `Mako` `Grim` `Slurp` `Kitty` `Foot` `Wlogout` `Kanshi`

### Gaming
`Steam` `Lutris` `Wine` `Proton` `GameMode` `GameScope` `MangoHud` `vkBasalt` `RetroArch` `Dolphin` `PCSX2` `PPSSPP`

### Sviluppo
`git` `neovim` `helix` `tmux` `zsh` `fish` `fzf` `ripgrep` `fd` `bat` `eza` `zoxide` `starship` `podman` `distrobox` `VS Code` `Rust` `Go` `Node.js` `Python`

### Multimedia
`OBS Studio` `VLC` `mpv` `GIMP` `Inkscape` `Kdenlive` `Audacity` `Blender` `ffmpeg` `PipeWire` `EasyEffects`

### Sistema
`Nvidia drivers` `CUDA` `nvidia-container-toolkit` `firewalld` `tlp` `thermald` `fwupd` `flatpak` `snapd`

## Prerequisiti

- Account GitHub
- Una macchina con bootc (es. Fedora Silverblue/Kinoite)
- Docker remoto per build (opzionale, vedi sotto)

## Setup

### 1. Genera chiave cosign

```bash
COSIGN_PASSWORD="" cosign generate-key-pair
```

> **IMPORTANTE**: Non committare MAI `cosign.key` nel repository!

### 2. Configura GitHub Secrets

Vai su `Settings > Secrets and Variables > Actions`:

| Secret | Valore |
|--------|--------|
| `SIGNING_SECRET` | Contenuto di `cosign.key` |

Opzionale per upload S3: `S3_PROVIDER`, `S3_BUCKET_NAME`, `S3_ACCESS_KEY_ID`, `S3_SECRET_ACCESS_KEY`, `S3_REGION`, `S3_ENDPOINT`

### 3. Personalizza

Modifica `build_files/build.sh` per aggiungere/rimuovere pacchetti.

## Build

### Build locale (Docker remoto su 192.168.1.145)

```bash
# Verifica connessione Docker remoto
just docker-info

# Build immagine container
just build

# Build ISO avviabile
just build-iso

# Build QCOW2 (per VM)
just build-qcow2

# Build RAW
just build-raw

# Pulizia
just clean
```

### Build manuale (senza just)

```bash
# Build
docker -H tcp://192.168.1.145:2375 build -t lightos:latest .

# Build ISO
docker -H tcp://192.168.1.145:2375 run --rm -it --privileged \
    -v ./disk_config:/disk_config \
    -v ./output:/output \
    quay.io/centos-bootc/bootc-image-builder:latest \
    --type iso --local lightos:latest
```

## Passa a LIGHTOS

```bash
sudo bootc switch ghcr.io/YOUR_USERNAME/lightos
sudo reboot
```

## Build automatiche

Le GitHub Actions buildano e pubblicano automaticamente su GHCR ad ogni push su `main`.

Per generare immagini disco: `Actions > Build LIGHTOS Disk Image > Run workflow`.

## Configurazione Docker remoto

Per esporre Docker su `192.168.1.145`, modifica `/etc/docker/daemon.json`:

```json
{
  "hosts": ["unix:///var/run/docker.sock", "tcp://0.0.0.0:2375"]
}
```

Oppre con systemd (`/etc/systemd/system/docker.service.d/override.conf`):

```ini
[Service]
ExecStart=
ExecStart=/usr/bin/dockerd -H fd:// -H tcp://0.0.0.0:2375
```

Poi:
```bash
sudo systemctl daemon-reload
sudo systemctl restart docker
```

> **Nota**: Esporre Docker su TCP senza TLS è ok solo in LAN fidata. Per produzione usa TLS.

## Struttura repository

```
LIGHTOS/
├── .github/workflows/
│   ├── build.yml          # CI/CD: build + push + signing
│   └── build-disk.yml     # Build ISO/QCOW2/raw + S3 upload
├── build_files/
│   ├── build.sh           # Script principale di customizzazione
│   └── etc/               # File di configurazione aggiuntivi
├── disk_config/
│   └── iso.toml           # Config utente per disk images
├── Containerfile          # Definizione immagine base
├── Justfile               # Comandi di build
├── cosign.pub             # Chiave pubblica per verifica
├── artifacthub-repo.yml   # Artifact Hub integration
├── LICENSE
└── README.md
```

## Licenza

Apache-2.0
