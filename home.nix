{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;

  imports = [ ./device.nix ];

  nixpkgs.config.allowUnfree = true;

  programs.git = {
    enable = true;
    userName = "Sebastian Wålinder";
    userEmail = "s.walinder@gmail.com";
  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
  };

  programs.firefox = {
    profiles.my.settings = {"extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";};

    extensions = with pkgs.nur.repos.rycee.firefox-addons;
      [
        https-everywhere
      ];
  };

  # nixpkgs.config.firefox.enablePlasmaBrowserIntegration = true;

  services.lorri.enable = true;

  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "emacs";

    # pinentry-program /run/current-system/sw/bin/pinentry-emacs
    extraConfig = "allow-emacs-pinentry";
    # grabKeyboardAndMouse = false;
  };

  # xsession.pointerCursor.size = 32;
  xsession.pointerCursor.package = pkgs.vanilla-dmz;
  xsession.pointerCursor.name = "Vanilla-DMZ";

  home.packages = with pkgs; [
    # mpd
    # mpc_cli

    brightnessctl

    git
    git-lfs

    gnupg

    pavucontrol

    lm_sensors

    ripgrep

    atool unzip
    # TODO Find replacement
    # p7zip

    direnv lorri

    # mail
    isync msmtp mu

    gimp
    redshift

    firefox plasma-browser-integration w3m

    shellcheck

    cmake libtool gnumake

    haskellPackages.structured-haskell-mode pinentry_emacs libvterm

    emacs

    # haskellPackages.glance - not on hackage
    # haskellPackages.visualize-cbn - marked as broken

    cloc

    imagemagick

    aspell aspellDicts.en aspellDicts.sv # languagetool # jre

    mpv

    # Needed by cabal?
    binutils

    # Haskell
    ghc cabal-install hlint haskellPackages.hoogle

    haskellPackages.hp2pretty # haskellPackages.threadscope # haskellPackages.eventlog2html

    ormolu
    nixfmt

    nix-prefetch nix-prefetch-git nix-prefetch-github

    # Used by hlint-refactor-mode
    # haskellPackages.apply-refact

    # Broken
    # haskellPackages.halive

    # haskellPackages.ghc-imported-from
    # Applications

    # Closed source
    spotify

    next

    pandoc
  ];

  home.stateVersion = "20.03";
}
