[![AGPL](https://img.shields.io/badge/License-AGPL%20v3-blue.svg)](https://en.wikipedia.org/wiki/Affero_General_Public_License)
[![project chat](https://img.shields.io/badge/zulip-join_chat-brightgreen.svg)](https://nixos.zulipchat.com/#narrow/stream/413948-nixos)
[![Harmless Code of Conduct](https://img.shields.io/badge/harmless-8A2BE2)](https://srid.ca/coc "This project follows the 'Harmlessness Code of Conduct'")

This repository contains the Nix / NixOS configuration for all of my systems. See [nixos-flake](https://community.flake.parts/nixos-flake) if you want to create your own configuration from scratch.

## Setup

To use this repository as base configuration for your new machine running:

### NixOS Linux

> [!TIP]
> For a general tutorial, see https://nixos.asia/en/nixos-install-flake

- Install NixOS
  - Hetzner dedicated from Linux Rescue system: https://github.com/numtide/nixos-anywhere (see [blog post](https://galowicz.de/2023/04/05/single-command-server-bootstrap/); example PR: https://github.com/srid/nixos-config/pull/35 where I had to configure networking manually)
    - Copy from existing configuration (eg: ax41.nix)
    - Make networking configuration changes.
    - Run nixos-anywhere from a Linux system, targetting `root@<ip>`
    - Wait for reboot; `ssh srid@<ip>`; profit!
  - Digital Ocean
    - Legacy/manual approach: [nixos-infect](https://github.com/elitak/nixos-infect)
    - Modern/automate approach: Custom image + colerama; cf. [Zulip](https://nixos.zulipchat.com/#narrow/stream/413948-nixos/topic/Deploying.20to.20DigitalOcean) and [example](https://github.com/fpindia/fpindia-chat)
  - X1 Carbon: https://srid.ca/x1c7-install
  - Windows (via WSL): https://github.com/nix-community/NixOS-WSL
- Clone this repo anywhere
- Edit `flake.nix` to use your system hostname as a key of the `nixosConfigurations` set
- Edit `users/config.nix` to contain your users
- Run `nix run`. That's it. Re-open your terminal.

### macOS

- [Install Nix](https://nixos.asia/en/install)
- Clone this repo anywhere
- Edit `flake.nix` to use your system hostname as a key of the `darwinConfigurations` set
- Edit `users/config.nix` to contain your users
- Run `nix run`.[^cleanup] That's it. Re-open your terminal.

[^cleanup]: You might have to `rm -rf /etc/nix/nix.conf`, so our flake.nix can do its thing.

## Architecture

Start from `flake.nix` (see [Flakes](https://nixos.wiki/wiki/Flakes)). [`flake-parts`](https://flake.parts/) is used as the module system.

### Directory layout

- `home`: home-manager config (shared between Linux and macOS)
- `nixos`: nixos modules for Linux
- `nix-darwin`: nix-darwin modules for macOS
- `users`: user information
- `systems`: top-level configuration.nix('ish) for various systems

## Tips

- To update NixOS (and other inputs) run `nix flake update`
  - You may also update a subset of inputs, e.g.
    ```sh
    nix flake lock --update-input nixpkgs --update-input darwin --update-input home-manager
    # Or, `nix run .#update`
    ```
- To free up disk space,
  ```sh-session
  sudo nix-env -p /nix/var/nix/profiles/system --delete-generations +2
  sudo nixos-rebuild boot
  ```
- To autoformat the project tree using nixpkgs-fmt, run `nix fmt`.
- To build all flake outputs (locally or in CI), run `nix --accept-flake-config run github:srid/nixci build`
- For secrets management, I use [ragenix](https://github.com/yaxitech/ragenix).

## Discussion

If you wish to discuss about this config, [join the Zulip](https://nixos.zulipchat.com/login/?next=/).

## Deploying on Remote Server

Using [nixos-infect](https://github.com/elitak/nixos-infect) (Successful on Ubuntu 24.04 LTS x64)

To install Manually,

```bash
  curl https://raw.githubusercontent.com/elitak/nixos-infect/master/nixos-infect | NIX_CHANNEL=nixos-23.05 bash -x
```

Or Automatically using `Cloud-Init User-Data`,

```bash
#!/bin/sh

curl https://raw.githubusercontent.com/elitak/nixos-infect/master/nixos-infect | NIX_CHANNEL=nixos-23.05 bash
```

After nix is instantiated, change and update nix channels.

```bash
nix-channel --add https://channels.nixos.org/nixos-24.05 nixos
nix-channel --add https://channels.nixos.org/nixos-unstable nixos-unstable
nix-channel --update
```

And then bootstrap with manual script `./manual_scripts/init-configuration.nix`.

```bash
nixos-rebuild switch
```

After bootstrapping, install further with flake configs with created user.

```bash
mkdir -p ~/repos/nixos/config && cd $_

git clone https://github.com/testfailed/nixos-config-srid
cd nixos-config-srid

nixos-rebuild switch
```

## Reference

### Examples & Tutorials

- [Learn Nix the Fun Way](https://fzakaria.com/2024/07/05/learn-nix-the-fun-way.html)

Build into the nix store.

```bash
nix-build ./examples/what-is-my-ip.nix

# Visualize the dependency graph.
nix-store --query --graph $(nix-build ./examples/what-is-my-ip.nix) | \
  dot -Tsvg -o what-is-my-ip-deps.svg
```

Build and include in a shell environment.

```bash
nix-shell ./examples/what-is-my-ip-shell.nix
```

Build into a docker image and run it.

```bash
docker load < $(nix-build ./examples/what-is-my-ip-docker.nix)
# => Loaded image: what-is-my-ip-docker:c9g6x30invdq1bjfah3w1aw5w52vkdfn

docker run -it --rm what-is-my-ip-docker:c9g6x30invdq1bjfah3w1aw5w52vkdfn
```
