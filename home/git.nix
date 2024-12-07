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

      dft = "difftool";
      dlog = "-c diff.external=difft log -p --ext-diff";
      mt = "mergetool";

      a = "add";
      aa = "add --all";
      ai = "add --interactive";

      b = "branch";
      bd = "branch -d";
      bm = "branch -m";
      bu = "branch -u";
      bv = "branch -vv";

      c = "commit --verbose";
      ca = "commit --verbose --amend";
      cm = "commit --verbose --message";
      cnv = "commit --verbose --no-verify";

      cl = "clone";
      clr = "clone --recurse-submodules";

      cnf = "config";
      cnfg = "config --global";

      co = "checkout";
      cob = "checkout -b";
      coo = "checkout --ours";
      cot = "checkout --theirs";

      d = "diff";
      dca = "diff --cached";

      f = "fetch";
      fa = "fetch --all --jobs=10";
      fap = "fetch --all --jobs=10 --prune";

      hh = "help";

      l = "log --graph --decorate --abbrev-commit";
      la = "l --all --tags --branches --remotes --perl-regexp --author='^((?!Renovate Bot|dependabot).*)$'";
      lp = "l --patch";
      ls = "l --stat";
      lsa = "la --stat";
      lsp = "l --stat --patch";
      lspa = "lsa --patch";

      m = "merge";
      ma = "merge --abort";
      mc = "merge --continue";
      mf = "merge --ff-only";

      p = "push";

      rs = "restore";
      rst = "restore --staged";

      j = "status";

      st = "stash";
      stap = "stash apply";
      stc = "stash clear";
      std = "stash drop";
      sth = "stash";
      stk = "stash --keep-index";
      stkm = "stash --keep-index --message";
      stl = "stash list";
      stp = "stash pop";
      sts = "stash show";
      stu = "stash push";

      t = "tag";
      td = "tag -d";
      tdf = "tag -d -f";

      ui = "update-index";

      ver = "version";
    };

    delta = {
      enable = true;

      options = {
        features = "decorations";
        navigate = true;
        light = false;
        line-numbers = true;
        side-by-side = true;
      };
    };

    difftastic = {
      # enable = true; # ==: false

      background = "dark"; # ==: "light"
      color = "always"; # ==: "auto"
      # display = "side-by-side"; # ==: "side-by-side"
      display = "inline"; # ==: "side-by-side"
    };

    extraConfig = {

      clean = {
        requireForce = true;
      };

      color = {
        ui = true;
      };

      core = {
        fileMode = false;
        ignoreCase = false;
        # fsmonitor = true;
        # untrackedCache = true;
        quotePath = false;
        eol = "native";
        safeCrlf = "warn";
        autoCrlf = "input";
        symlinks = true;
        # excludesFile = "~/.gitignore_global";
        editor = "nvim";
        # pager = "delta";
        abbrev = 7;
      };

      # credential.helper = "store --file ~/.git-credentials";

      # [delta]
      #   navigate = true     # use n and N to move between diff sections.
      #   light = false       # set to true if you're in a terminal w/ a light
      #                       # background color (e.g. the default macOS terminal).
      #   line-numbers = true
      #   side-by-side = true # `export DELTA_FEATURES=+` to disable.

      # delta = {
      #   navigate = true; # use n and N to move between diff sections.
      #   light = false; # set to true if you're in a terminal w/ a light background color (e.g. the default macOS terminal).
      #
      #   line-numbers = true;
      #   side-by-side = true; # `export DELTA_FEATURES=+` to disable.
      # };

      diff = {
        colorMoved = "default";
        # external = "difftastic";
        # tool = "difftastic";
      };

      difftool = {
        prompt = false;
      };

      # "difftool \"delta\"" = {
      #   cmd = "delta --color-only";
      # };

      "difftool \"difftastic\"" = {
        cmd = "difft \"\$LOCAL\" \"\$REMOTE\"";
      };

      format = {
        pretty = "%C(auto)%h %<(5)%s %C(green)%ad %C(bold blue)%an%C(auto)%d";
      };

      init = {
        defaultBranch = "main"; # Undo breakage due to https://srid.ca/luxury-belief
      };

      # interactive = {
      #   diffFilter = "delta --color-only";
      # };

      log = {
        # date = "format-local:\"%F %R\"";
        date = "format-local:%F %R";
      };

      merge = {
        tool = "diff3";
      };

      pager = {
        difftool = true;
      };

      # protocol.keybase.allow = "always";

      pull = {
        ff = "only";
        rebase = "false";
      };

      push = {
        default = "simple";
      };

      status = {
        submoduleSummary = 1;
      };
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
