# Playing OverTheWire Wargames

## About overthewire.sh

This script simplifies playing [OverTheWire Wargames](https://overthewire.org/wargames/) (currently supports **Bandit**, **Leviathan**, and **Narnia**) by handling connection details and managing password storage automatically.

## How it works

The script connects to the current level using `sshpass` if the password is stored. If not, it falls back to a manual SSH connection. After each run, it asks if you've cleared the level and prompts to save the password for the next level.

## Installation

### Prerequisites

Ensure you have the following installed:

- `sshpass`
- `rsync`
- `bash`

### Manual Installation

Since there is no install script, you can set it up manually:

1.  Make the script executable:
    ```bash
    chmod +x otw.sh
    ```
2.  (Optional) Create a symlink to run it from anywhere:
    ```bash
    ln -s "$(pwd)/otw.sh" ~/.local/bin/otw
    ```

## Usage

```bash
./otw.sh --game [bandit|leviathan] ...
```

OR if symlinked:

```bash
otw --game [bandit|leviathan] ...
```

- **Default Game**: `bandit` (if `--game` is omitted).
- **Shortcuts**: You can use `-g b` for bandit or `-g l` for leviathan.
- **Sync**: `--sync` and `--pull` now synchronize **ALL** configured games at once.

## Storage

All game data is stored in your local configuration directory: `~/.config/bandit/`.

- **Progress**: Your current level is tracked in `bandit_level.conf`.
- **Passwords**: Retrieved passwords are securely stored in the `passwords/` subdirectory (e.g., `passwords/level5`).

## Sync and Backup

The script supports syncing your progress to a remote server using `rsync`.

### 1. Configure SSH (Recommended)

Add your server to `~/.ssh/config` to enable password-less sync:

```ssh
Host my-game-server
  HostName 192.168.1.100      # Replace with your server's IP
  User myuser                 # Replace with your server username
  IdentityFile ~/.ssh/id_rsa  # Path to your private SSH key
  IdentitiesOnly yes
```

### 2. Configure Bandit

Edit `~/.config/bandit/bandit_level.conf` to point to your SSH alias:

```bash
SYNC_HOST=""    # Set this to your Host alias (e.g., 'my-game-server')
SYNC_DIR=""     # Path to remote backup directory
```

### 3. Usage

- **Push**: The script offers to sync after storing a new password. Force push with `./bandit.sh --sync`.
- **Pull**: Retrieve passwords from the server using `./bandit.sh --pull`. This updates `passwords/` without overwriting config.

## Why Sync?

## Release Notes

### v0.2

- **Multi-Game Support**: Play **Bandit**, **Leviathan**, and **Narnia** using the `--game` flag.
- **Unified Sync**: `--sync` backsup progress for **all** configured games at once.
- **Game Completion**: Detects when you finish a game (via `MAX_LEVEL`) and shows a congratulatory message.
- **Dynamic Configuration**: Easily add new games by dropping a file into `configs/`.

### v0.1

- Initial release supporting Bandit.
