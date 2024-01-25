https://status.nixos.org/

sudo nix-channel --update

# after editing /etc/nixos/configuration.nix
sudo nixos-rebuild switch

# upgrade packages:
sudo nixos-rebuild switch --upgrade

# uninstall stuff installed with nix-env:
nix-env --query --installed
nix-env --uninstall firefox-109.0.1 jmtpfs-0.5 librespot-0.4.2



export NIXPKGS_ALLOW_INSECURE=1
