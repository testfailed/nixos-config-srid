{
  programs.nixvim = {
    plugins.auto-session = {
      enable = true; # *: false

      bypassSessionSaveFileTypes = null;
      logLevel = "info"; # *: "error"

      autoRestore.enabled = true; # *: false

      autoSave.enabled = true; # *: false

      autoSession = {
        # Enables/disables auto creating, saving and restoring.
        enabled = true; # _: true

        # Whether to enable the “last session” feature.
        enableLastSession = true; # *: false

        createEnabled = true; # *: null
        rootDir = { __raw = "vim.fn.stdpath 'data' .. '/sessions/'"; };
        suppressDirs = null;
        useGitBranch = true; # *: null
      };

      # sessionLens =
    };
  };
}
