{ pkgs, config, flake, ... }:
{
  home.packages = with pkgs; [
    git-lfs
    git-filter-repo
  ];

  programs.git = {
    enable = true;

    package = pkgs.gitAndTools.gitFull;
    userName = flake.config.people.users.${config.home.username}.name;
    userEmail = flake.config.people.users.${config.home.username}.email;

    aliases = {
      co = "checkout";
      ci = "commit";
      cia = "commit --amend";
      s = "status";
      st = "status";
      b = "branch";
      # p = "pull --rebase";
      pu = "push";
    };

    iniContent = {
      # Branch with most recent change comes first
      branch.sort = "-committerdate";

      # Remember and auto-resolve merge conflicts
      # https://git-scm.com/book/en/v2/Git-Tools-Rerere
      rerere.enabled = true;
    };

    ignores = [ "*~" "*.swp" ];

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
  };

  programs.lazygit = {
    enable = true;
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
