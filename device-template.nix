{ pkgs, ... }:
{
  imports = [
    ./modules/email.nix
    # ./modules/games/cataclysm-dda/cataclysm-dda-git-latest.nix
    # ./modules/build-emacs.nix
    # ./modules/art.nix
  ];
  # programs.git = {
  #   signing = {
  #     key = "";
  #     signByDefault = true;
  #   };
  # };
  home.packages = with pkgs; [
  ];

  accounts.email = {
    accounts.main-gmail = {
      passwordCommand = "echo gmail-app-password";
    };
  };
}
