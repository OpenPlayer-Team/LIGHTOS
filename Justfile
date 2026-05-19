# ============================================================
# LIGHTOS - Justfile
# ============================================================

image_name := "lightos"
default_tag := "latest"
bib_image := "quay.io/centos-bootc/bootc-image-builder:latest"

# --- Build container image ---
build target_image=image_name tag=default_tag:
    docker build -t {{ target_image }}:{{ tag }} .

# --- Build QCOW2 disk image ---
build-qcow2 target_image=image_name tag=default_tag:
    docker run --rm -it \
        --privileged \
        -v {{ invocation_directory() }}/disk_config:/disk_config \
        -v {{ invocation_directory() }}/output:/output \
        {{ bib_image }} \
        --type qcow2 \
        --local \
        {{ target_image }}:{{ tag }}

# --- Rebuild QCOW2 ---
rebuild-qcow2 target_image=image_name tag=default_tag:
    rm -f ./output/qcow2/disk.qcow2
    just build-qcow2 {{ target_image }} {{ tag }}

# --- Build ISO ---
build-iso target_image=image_name tag=default_tag:
    docker run --rm -it \
        --privileged \
        -v {{ invocation_directory() }}/disk_config:/disk_config \
        -v {{ invocation_directory() }}/output:/output \
        {{ bib_image }} \
        --type iso \
        --local \
        {{ target_image }}:{{ tag }}

# --- Build RAW ---
build-raw target_image=image_name tag=default_tag:
    docker run --rm -it \
        --privileged \
        -v {{ invocation_directory() }}/disk_config:/disk_config \
        -v {{ invocation_directory() }}/output:/output \
        {{ bib_image }} \
        --type raw \
        --local \
        {{ target_image }}:{{ tag }}

# --- Lint bash scripts ---
lint:
    shellcheck build_files/*.sh

# --- Format bash scripts ---
format:
    shfmt -w build_files/*.sh

# --- Clean build artifacts ---
clean:
    rm -rf ./output
    docker rmi {{ image_name }}:{{ default_tag }} 2>$null; exit 0

# --- Check justfile syntax ---
check:
    just --check --fmt

# --- Fix justfile syntax ---
fix:
    just --fmt

# --- Docker info ---
docker-info:
    docker info
    docker version
