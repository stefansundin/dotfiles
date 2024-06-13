# https://status.nixos.org/

# edit configuration.nix:
sudo subl /etc/nixos/configuration.nix
sudo nixos-rebuild switch

# update current nix channel:
sudo nix-channel --update

# upgrade packages:
sudo nixos-rebuild switch --upgrade

# upgrade nix channel:
sudo nix-channel --list
sudo nix-channel --add https://nixos.org/channels/nixos-24.05 nixos
sudo nix-channel --update
sudo nixos-rebuild boot --upgrade
sudo reboot

# uninstall stuff installed with nix-env:
nix-env --query --installed
nix-env --uninstall firefox-109.0.1 jmtpfs-0.5 librespot-0.4.2

# clean up junk:
nix-env --delete-generations old
sudo nix-store --gc
sudo nix-collect-garbage -d



export NIXPKGS_ALLOW_INSECURE=1
