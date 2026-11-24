# SEU-Linux-Distro
SEU (Secure Ease of Use) Linux, a Debian-based Linux Distro made using live-build. All built-in applications are to be open source. It is meant to be mostly a plug and play type of Linux Distro.

## How It Works

### Brief
This repository contains the files and code that will be packaged in an x86_64 Docker container, in order to be built by GitHub Actions.

The build process involves creating a live image of the SEU Linux distribution using the live-build tool, ensuring that all included applications are open source and the system remains user-friendly and secure.

Once the image is built in GitHub, its ISO file will be available for download, allowing users to run it on their own VM or on physical hardware.

### Docker Environment
The repository contains all the necessary config files needed to create the image, and contains the Docker settings to build the image within a container environment, ensuring a consistent and reproducible build process across various machines.

#### Docker Container:
- linux/amd64 (x86_64 architecture)
- 8 GB RAM
- 4+ CPUs
- 40 GB disk

The softwares used for the Docker environment include live-build, debootstrap, squashfs-tools, xorriso, syslinux, syslinux-utils, isolinux, grub-efi-amd64-bin, grub-pc-bin, mtools, dosfstools, ca-certificates, curl, and gnupg.

### ISO Settings

The ISO image generated has the following settings (auto/config):
- Base: Debian 13 (trixie)
- Architecture: amd64 (x86_64)
- Binary Images: iso-hybrid
- Bootloaders: syslinux, grub-efi
- Debian Installer: none
- Archive Areas: main contrib non-free-firmware
- Chroot SquashFS Compression Type: gzip
- ISO Application: SEU Linux
- ISO Volume: SEU_LINUX
- Memtest: none

### What is Included

**Base system and desktop** (Debian packages)
Debian 13 with the XFCE desktop, LightDM login manager, NetworkManager, and basic system tools.

**Applications from Debian's repositories**
- Firefox ESR (web browser)
- Timeshift (system snapshots and recovery)

## How to Run

### Running the ISO

#### Requirements
- A virtual machine program (VirtualBox, VMware, UTM, or QEMU), or a USB stick (4 GB or larger) to boot a physical machine
- 4 GB RAM (2 GB minimum)
- 2+ CPUs
- About 3 GB of free disk space to store the ISO file

#### Steps
1. Download the ISO file from the GitHub Actions build artifacts.
2. Create a new VM in your preferred virtual machine software, or place it in a bootable USB drive to run on physical hardware.
3. Boot from the ISO. SEU Linux starts directly into the desktop. Changes are kept in RAM and lost on shutdown.

#### Running with QEMU

Install qemu `brew install qemu` on macOS, or use your package manager on Linux (e.g., `sudo apt install qemu`).

Navigate to the directory containing the ISO file, then run the following command to start the ISO with QEMU:
```bash
qemu-system-x86_64 \
  -m 4G -smp 2 \
  -accel tcg \
  -cdrom seu-linux.iso -boot d \
  -vga std \
  -device qemu-xhci -device usb-tablet \
  -nic user,model=virtio-net-pci
```

### OR

### Customizing / Building Separately

#### Requirements
- Docker Desktop or Docker Engine installed on your system
- 4 GB RAM (2 GB minimum)
- 2+ CPUs
- No disk space needed (runs live from the ISO)
- **It is highly recommended** to use a native x86_64 host system for building the Docker container and generating the ISO image, since running on a different architecture relies on emulation, which may lead to slower build times and potential compatibility issues.

#### Steps
1. Clone or fork this repository to your local system.
2. Navigate to the repository directory.
3. Customize the build configuration files as needed.
4. Build the Docker container using the provided Docker settings.
```bash
docker build --platform linux/amd64 -t seu-builder .
```
5. Run the container to generate the live image of SEU Linux
```bash
docker run --rm --privileged -v "$PWD":/src seu-builder bash /src/build.sh
```
6. When the build finishes, the ISO is at out/seu-linux.iso. Use it in a VM or on physical hardware.