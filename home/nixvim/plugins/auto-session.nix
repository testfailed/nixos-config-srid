{
  programs.nixvim = {
    plugins.auto-session = {
      enable = true;

      logLevel = "warn";
      autoRestore.enabled = true; # *: null
      autoSave.enabled = true; # *: null

      autoSession = {
        enabled = true;

        createEnabled = true; # *: null
        useGitBranch = true; # *: null
      };

      # sessionLens =
    };
  };
}
