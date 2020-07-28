{ config, pkgs, ... }:
let
  unstable = import
    (builtins.fetchTarball https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz)
    # reuse the current configuration
    { config = config.nixpkgs.config; };
in
{
  services.spotifyd.package = (unstable.spotifyd.override { withMpris = true; withPulseAudio = true; withALSA = false;});

  services.spotifyd.enable = true;
}
