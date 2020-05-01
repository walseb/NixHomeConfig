{ pkgs, ... }:
{
  # programs.git = {
  #   signing = {
  #     key = "";
  #     signByDefault = true;
  #   };
  # };

  programs.mbsync.enable = true;
  programs.msmtp.enable = true;

  accounts.email = {
    accounts.main-gmail = {
      passwordCommand = "echo gmail-app-password";

      primary = true;

      realName = "Sebastian Wålinder";
      userName = "s.walinder@gmail.com";
      address = "s.walinder@gmail.com";

      imap.host = "imap.gmail.com";
      mbsync = {
        enable = true;
        create = "maildir";
      };

      # Encrypted email
      # gpg = {
      #   key = "";
      #   signByDefault = true;
      # };

      smtp = {
        host = "smtp.gmail.com";
        port = 587;
        tls.enable = true;
      };

      msmtp.enable = true;
    };
  };
}
