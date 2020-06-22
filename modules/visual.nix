{ pkgs, ... }:
{
  # xsession.pointerCursor.size = 32;
  xsession.pointerCursor.package = pkgs.vanilla-dmz;
  xsession.pointerCursor.name = "Vanilla-DMZ";

  fonts.fontconfig.enable = true;
}
