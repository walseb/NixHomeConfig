{ config, pkgs, lib, ... }:

# https://github.com/NixOS/nixpkgs/blob/master/pkgs/applications/editors/emacs/default.nix

let
  withGTK2 = false;
  withGTK3 = true;

  withXwidgets = false;

  withJson = true;
  withHarfbuzz = true;
  withoutGTKScrollbars = true;

  gtk2-x11 = null;
  gsettings-desktop-schemas = null;

  toolkit =
    if withGTK2 then "gtk2"
    else if withGTK3 then "gtk3"
    else "lucid";
in
{
  nixpkgs.config = {
    # Install emacs git
    # /nix/var/nix/profiles/per-user/root/channels/nixos/pkgs/applications/editors/emacs/default.nix
    packageOverrides = pkgs: {

      emacs = (pkgs.emacs.override { srcRepo = true; }).overrideAttrs (old: rec {
        name = "emacs-${version}${versionModifier}";
        version = "27";
        versionModifier = "-git";

        buildInputs =
          [ pkgs.ncurses pkgs.libxml2 pkgs.gnutls pkgs.alsaLib pkgs.acl pkgs.gpm pkgs.gettext ]
          ++ [ pkgs.dbus pkgs.libselinux pkgs.systemd ]
          ++ [ pkgs.xlibsWrapper pkgs.xorg.libXaw pkgs.Xaw3d pkgs.xorg.libXpm pkgs.libpng pkgs.libjpeg pkgs.libungif pkgs.libtiff pkgs.librsvg pkgs.xorg.libXft ]
          ++ [ pkgs.m17n_lib pkgs.libotf ]
          ++ lib.optional withGTK2 gtk2-x11
          ++ lib.optionals withGTK3 [ pkgs.gtk3-x11 pkgs.gsettings-desktop-schemas ]
          ++ lib.optionals withXwidgets [ pkgs.webkitgtk ]
          ++ lib.optionals withJson [ pkgs.jansson ];

          configureFlags =
            [ "--with-modules" ]
             ++ [ "--with-x-toolkit=${toolkit}" "--with-xft" ]
             ++ lib.optional withXwidgets "--with-xwidgets"
             ++ lib.optional withJson "--with-json"
             ++ lib.optional withHarfbuzz "--with-harfbuzz"
             ++ lib.optional withoutGTKScrollbars "--without-toolkit-scroll-bars";

          src = pkgs.fetchFromGitHub {
            owner = "emacs-mirror";
            repo = "emacs";

            # Remember to change BOTH rev and sha256, otherwise it doesn't clone correctly
            rev = "b3bbd4fd00562578e840fbdaec5ed2000392d9e3";
            sha256 = "0wrca90xapnwrhg977vjc1rahd60w0dvzwm6q84gd8ildrdgnzql";
          };
          patches = [];
      });
    };
  };
}
