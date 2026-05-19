# LIGHTOS - Bootc Image
# Base: Fedora Bootc 42 + Nvidia + Hyprland + Gaming + Dev
# Build: docker build -t lightos:latest .

FROM quay.io/fedora/fedora-bootc:42

# Copia e esegui lo script di build
COPY build_files/build.sh /tmp/build.sh
RUN chmod +x /tmp/build.sh && /tmp/build.sh && rm -f /tmp/build.sh
