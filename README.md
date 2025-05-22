<div>
  <h1 align="center">❄️ My NixOs Configs ❄️<p align="center" dir="auto"> </p></h1>
</div>

This repository contains my personal Nix configuration (NixOS and Home Manager). It uses Nix flakes and is meant to be reproducible. Feel free to use, fork, or reference it for your setup.

---

## ⚡ Screenshots
<div align="center">
  <img  align="center" src="https://github.com/user-attachments/assets/7a398c64-6659-4a14-bb7b-fec38b3dc40c" width="800">
</div>
<br>
<div align="center">
  <img  align="center" src="https://github.com/user-attachments/assets/87c925ac-da51-4e1c-aab3-b274d7700415" width="800">
</div>

## 📁 File Structure

* `home/` – Home Manager configurations for user environments
* `nixos/` – NixOS configurations for system-level setup
* `flake.nix` – Main Nix flake file, defines inputs/outputs
* `flake.lock` – Lock file for reproducible builds


## ⚙️ Installation & Usage

### 1. Enable Flakes

To enable Flakes, add the following line to your `configuration.nix` file (usually located at `/etc/nixos/configuration.nix`):

```nix
nix.settings.experimental-features = [ "nix-command" "flakes" ];
```

After saving the file, apply the changes by running:

```bash
sudo nixos-rebuild switch
```

This enables both the nix command and Flakes support system-wide.

### 2. Install Home Manager

```bash
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install
```

### 3. Clone this Repository

```bash
git clone https://github.com/RahulGotrekiya/nix-configs.git ~/dotfiles
cd ~/dotfiles
```

### 4. Replace hardware-configuration

Replace the contents of `~/dotfiles/nixos/hardware-configuration.nix` file with the one generated for your system, usually located at `/etc/nixos/hardware-configuration.nix`.

### 5. Build & Apply Config

#### NixOS system (replace `nixos` with your hostname):

```bash
sudo nixos-rebuild switch --flake .#nixos
```

#### Home Manager user config:

```bash
home-manager switch --flake .#rahul
```

---

<p align="center">
  Thank you ❤️
</p>
