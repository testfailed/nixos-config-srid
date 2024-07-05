{ pkgs, config, flake, ... }:

{
  home.packages = with pkgs; [
    git-filter-repo
  ];

  programs.git = {
    enable = true; # ==: false
    package = pkgs.gitAndTools.gitFull;

    ignores = [ "*~" "*.swp" ];
    lfs.enable = true;
    userEmail = flake.config.people.users.${config.home.username}.email;
    userName = flake.config.people.users.${config.home.username}.name;

    aliases = {
      # p = "pull --rebase";
      b = "branch";
      ci = "commit";
      cia = "commit --amend";
      co = "checkout";
      pu = "push";
      s = "status";
      st = "status";
    };

    delta = {
      enable = true;
      options = {
        features = "decorations";
        navigate = true;
        light = false;
        side-by-side = true;
      };
    };

    extraConfig = {
      init.defaultBranch = "main"; # Undo breakage due to https://srid.ca/luxury-belief
      core.editor = "nvim";
      # protocol.keybase.allow = "always";
      # credential.helper = "store --file ~/.git-credentials";
      pull.rebase = "false";
    };

    iniContent = {
      # Branch with most recent change comes first
      branch.sort = "-committerdate";

      # Remember and auto-resolve merge conflicts
      # https://git-scm.com/book/en/v2/Git-Tools-Rerere
      rerere.enabled = true;
    };
  };

  programs.lazygit = {
    enable = true; # ==: false

    settings = {
      # This looks better with the kitty theme.
      gui.theme = {
        lightTheme = false;
        activeBorderColor = [ "white" "bold" ];
        inactiveBorderColor = [ "white" ];
        selectedLineBgColor = [ "reverse" "white" ];
      };
    };
  };
}
