# REF: <https://nix-community.github.io/nixvim/plugins/auto-session/index.html>
# REF: <https://github.com/rmagatti/auto-session#options>
{
  programs.nixvim = {
    plugins.auto-session = {
      enable = true; # *: false

      logLevel = "info"; # *: "error"
      bypassSessionSaveFileTypes = null;

      autoRestore.enabled = true; # *: false

      autoSave.enabled = true; # *: false

      autoSession = {
        # Enables/disables auto creating, saving and restoring.
        enabled = true; # _: true

        # Whether to enable the “last session” feature.
        enableLastSession = false; # ==: false

        createEnabled = true; # *: null
        rootDir = { __raw = "vim.fn.stdpath 'data' .. '/sessions/'"; };
        suppressDirs = null;
        useGitBranch = true; # *: null
      };

      # sessionLens = {
      #   loadOnSetup = true;
      #   previewer = true; # *: null ## false
      #   themeConf = {
      #     border = true;
      #     winblend = 10;
      #   }; # *: null
      # };
    };

    keymaps = [
      {
        mode = "n";
        key = "<Leader>qq";
        action = "<Cmd>SessionSave<CR> <Bar> <Cmd>qa<CR>";
        options = {
          desc = "Save session and quit";
        };
      }

      {
        mode = "n";
        key = "<Leader>qs";
        action = "<Cmd>SessionSave<CR>";
        options = {
          desc = "Save session";
        };
      }

      {
        mode = "n";
        key = "<Leader>qr";
        action = "<Cmd>SessionRestore<CR>";
        options = {
          desc = "Restore session";
        };
      }
    ];

  };
}
