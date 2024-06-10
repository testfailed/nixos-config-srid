let
  # # https://pimalaya.org/himalaya/cli/latest/configuration/icloud-mail.html
  # iCloudMailSettings = {
  #   imap = {
  #     host = "imap.mail.me.com";
  #     port = 993;
  #   };
  #   smtp = {
  #     host = "smtp.mail.me.com";
  #     port = 587;
  #     tls.useStartTls = true;
  #   };
  # };

  # REF: <https://pimalaya.org/himalaya/cli/latest/configuration/gmail.html>
  gmailSettings = {
    imap = {
      host = "imap.mail.me.com";
      port = 993;
    };
    smtp = {
      host = "smtp.mail.me.com";
      port = 587;
      tls.useStartTls = true;
    };
  };
in
{
  home.shellAliases = {
    hl = "himalaya";
    hld = "himalaya message delete";
    hlr = "himalaya message read";
    hly = "himalaya account sync";
  };

  programs.himalaya = {
    enable = true;
  };

  accounts.email.accounts = {
    # "srid@srid.ca" = iCloudMailSettings // {
    #   primary = true;
    #   realName = "Sridhar Ratnakumar";
    #   address = "happyandharmless@icloud.com";
    #   aliases = [ "srid@srid.ca" ];
    #   userName = "happyandharmless";
    #   passwordCommand = "op read op://Personal/iCloud-Apple/himalaya";
    #   himalaya = {
    #     enable = true;
    #     # Don't forget to run `himalaya account sync` first!
    #     settings.sync = {
    #       enable = true;
    #     };
    #   };
    # };

    "clvswft03@gmail.com" = gmailSettings // {
      primary = true;
      realName = "Son Sumin";
      address = "clvswft03@gmail.com";
      # aliases = [];
      userName = "clvswft03";
      himalaya = {
        enable = true;
        # Don't forget to run `himalaya account sync` first!
        settings.sync = {
          enable = true;
        };
      };
    };
  };
}
