# Linux RPM Post-Install Script

Bash script that automates common application installs and desktop setup on Fedora-based (DNF/RPM) systems after a fresh install.

## What it does

On a new machine, the script:

1. Installs a fixed set of desktop and development applications
2. Applies GNOME theme and icon settings
3. Installs Visual Studio Code extensions
4. Prompts for Git `user.name` and `user.email`
5. Creates a `Projects` folder and clones selected GitHub repositories
6. Installs Zsh with Oh My Zsh and sets Zsh as the default shell
7. Installs the Dracula theme for GNOME Terminal

## Features

### Applications installed

| Step | Application | Install method |
|------|-------------|----------------|
| 1/9 | Spotify | Flatpak (`com.spotify.Client` from Flathub) |
| 2/9 | VirtualBox | RPM (`6.1.22` Fedora 33 package) plus `SDL`, `kernel-devel`, and `dkms` |
| 3/9 | Vagrant | RPM (`2.2.15`) |
| 4/9 | Bitwarden Desktop | RPM from Bitwarden download URL |
| 5/9 | ONLYOFFICE Desktop Editors | RPM, with `liberation-narrow-fonts` |
| 6/9 | GIMP | `dnf` |
| 7/9 | Vim | `dnf` |
| 8/9 | Visual Studio Code | Microsoft yum repository |
| 9/9 | Notion | Nativefier web app under `$HOME/WebApps` |

### Configuration steps

- **Theme and icons:** installs `gnome-shell-theme-flat-remix` and sets:
  - Icon theme: `Flat-Remix-Blue-Dark`
  - GTK theme: `Flat-Remix-GTK-Blue-Dark`
- **VS Code extensions:**
  - `formulahendry.auto-rename-tag`
  - `coenraads.bracket-pair-colorizer-2`
  - `naumovs.color-highlight`
  - `dracula-theme.theme-dracula`
  - `abusaidm.html-snippets`
  - `pkief.material-icon-theme`
  - `yzhang.markdown-all-in-one`
  - `ms-python.vscode-pylance`
- **Git:** interactive prompts for global `user.name` and `user.email`
- **Repositories:** creates `$HOME/Projects` and clones:
  - [youtube_downloader](https://github.com/marcoswb/youtube_downloader)
  - [personal-site](https://github.com/marcoswb/personal-site)
  - [script-pos-install](https://github.com/marcoswb/script-pos-install)
- **Shell:** installs Zsh, Oh My Zsh, `util-linux-user`, then runs `chsh -s $(which zsh)`
- **Terminal theme:** clones and runs the [Dracula GNOME Terminal](https://github.com/dracula/gnome-terminal) installer

## Technologies

- Bash
- DNF / RPM package management
- Flatpak / Flathub
- GNOME (`gsettings`, GNOME Terminal)
- Node.js / npm / Nativefier (for the Notion web app)
- Git
- Oh My Zsh

## Project structure

```text
.
├── install.sh   # Main post-install script
├── LICENSE      # MIT License
└── README.md
```

The script defines two functions and runs them in order:

1. `install_aplications` — application installs
2. `configurations` — theme, extensions, Git, repos, Zsh, terminal theme

## Prerequisites

- A Fedora-based Linux distribution that uses `dnf` and `rpm`
- GNOME desktop environment (theme settings and GNOME Terminal installer depend on it)
- Internet access (downloads packages and repositories)
- `sudo` privileges
- `git`, `curl`, and `wget` available (or installable via the script’s package manager usage)

There is no separate dependency manifest; packages are installed by the script itself.

## Installation and setup

Clone the repository (or download `install.sh`), then make the script executable:

```bash
git clone https://github.com/marcoswb/script-pos-install.git
cd script-pos-install
chmod +x install.sh
```

## Environment variables and configuration

This project does not use environment variables or external config files.

Runtime configuration is limited to interactive prompts for:

- Git `user.name`
- Git `user.email`

Application versions and repository URLs are hardcoded in `install.sh`.

## How to run

```bash
./install.sh
```

The script runs with elevated privileges for package installs (`sudo`). It will:

1. Install applications (progress labeled 1/9 through 9/9)
2. Apply configurations
3. Ask for Git name and email when it reaches that step

Oh My Zsh installation may also prompt for interactive confirmation, depending on the upstream installer behavior.

## Usage notes

- Expect a long run with multiple downloads and `sudo` password prompts.
- After completion, log out and back in (or reboot) so the default shell change from `chsh` takes effect.
- Notion is packaged with Nativefier; the app is created under `$HOME/WebApps` (see known issues below regarding the working directory).

## Tests

This repository does not include automated tests.

## Known issues and limitations

Based on the current `install.sh`:

- **Hardcoded package versions:** VirtualBox `6.1.22` (Fedora 33 RPM) and Vagrant `2.2.15` may be outdated or incompatible with newer kernels/distros.
- **Path typo for Notion:** the script creates `$HOME/WebApps` but then changes directory to `$HOME/WebAppps` before running Nativefier.
- **GNOME-only assumptions:** `gsettings` theme changes and the Dracula GNOME Terminal installer will not apply on non-GNOME desktops.
- **No error handling:** failed downloads or installs do not stop the script; later steps still run.
- **Interactive only:** Git identity and Oh My Zsh setup require user input; there is no non-interactive/CI mode.
- **Requires root via sudo:** not suitable for unprivileged environments.
- **Duplicate `sudo`:** the DKMS install line uses `sudo sudo dnf install dkms -y`.

## License

MIT License. Copyright (c) 2021 Marcos Warmling Berti. See [LICENSE](LICENSE).
