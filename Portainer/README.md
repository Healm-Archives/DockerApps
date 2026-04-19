
# Portainer Desktop Launcher

Launch Portainer in your browser directly from the system application menu — no terminal required after setup.

---

## Prerequisites

- Docker installed and running
- `zsh` installed
- A Linux desktop environment (GNOME, KDE, XFCE, etc.)

---

## Setup

### 1. Run Portainer Container

Run the setup script **once** to pull the Portainer image and start the container:

```zsh
chmod +x portainer-setup.zsh
./portainer-setup.zsh
```

This will:

- Pull the `portainer/portainer-ce` image
- Create a named volume for persistent data
- Start the container on port `9443`

> **Note:** You only need to run this once. The container will persist across reboots if Docker is set to start on boot.

---

### 2. Install the Launcher Script

The launcher script starts Portainer if it's not running, then opens it in your default browser.

```zsh
chmod +x portainer-launcher.zsh
cp portainer-launcher.zsh ~/.local/bin/portainer-launcher.zsh
```

---

### 3. Add to System Menu

Copy the `.desktop` entry to your local applications directory:

```bash
cp Portainer.desktop ~/.local/share/applications/
```

The `.desktop` file references:

- **Exec:** `/home/YOUR_USERNAME/.local/bin/portainer-launcher.zsh`
- **Icon:** the absolute path to `portainer.png`

Update the `Icon=` path in `Portainer.desktop` to match where you placed the icon:

```ini
Icon=/home/YOUR_USERNAME/.local/share/icons/hicolor/512x512/apps/portainer.png
```

---

Then refresh the desktop database:

```bash
update-desktop-database ~/.local/share/applications/
```

### 4. Set the Icon

Copy the icon to your local icons directory:

```bash
mkdir -p ~/.local/share/icons
cp portainer.png ~/.local/share/icons/hicolor/512x512/apps/portainer.png
```

Then refresh the local icon database:

> gtk-update-icon-cache -f ~/.local/share/icons/hicolor/

---

## File Reference

| File | Purpose |
| --- | --- |
| `portainer-setup.zsh` | One-time Docker container setup |
| `portainer-launcher.zsh` | Start container + open browser |
| `Portainer.desktop` | System menu entry definition |
| `portainer.png` | Application icon |

---

## Accessing Portainer

Once set up, Portainer is available at:

> <https://localhost:9443>

On first launch, you will be prompted to create an admin account.

---

## Troubleshooting

**Container not starting:**

```bash
docker ps -a | grep portainer
docker start portainer
```

**Icon not showing in menu:**  
Log out and log back in, or run:

```bash
update-desktop-database ~/.local/share/applications/
```

**Port 9443 already in use:**  
Edit `portainer-setup.zsh` and change `-p 9443:9443` to another port (e.g., `-p 9444:9443`), then update the URL in `portainer-launcher.zsh`.
