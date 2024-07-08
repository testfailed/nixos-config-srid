{
  programs.nixvim = {

    keymaps = [
      {
        mode = "n";
        key = "<Leader>e";
        # action = ":Neotree action=focus reveal toggle <Bar> :wincmd =<CR>";
        action = ":Neotree action=focus reveal toggle<CR>";
        options.silent = true;
      }

      {
        mode = "n";
        key = "<M-e>";
        action = ":Neotree action=focus<CR>";
        options.silent = true;
      }
    ];

    plugins.neo-tree = {
      enable = true; # *: false

      enableDiagnostics = true;
      enableGitStatus = true;
      enableModifiedMarkers = true;
      enableRefreshOnWrite = true;

      autoCleanAfterSessionRestore = true; # *: false
      closeIfLastWindow = false;
      defaultSource = "filesystem";
      openFilesInLastWindow = true; # *: false
      popupBorderStyle = "NC";

      filesystem = {
        asyncDirectoryScan = "auto";
        bindToCwd = true;
        findArgs = {
          fd = [
            "--exclude"
            ".cache"
            "--exclude"
            ".git"
            "--exclude"
            ".venv"
            "--exclude"
            "node_modules"
          ];
        };
        hijackNetrwBehavior = "open_default";
        searchLimit = 200; # *: 50
        useLibuvFileWatcher = true; # *: false
      };

      window = {
        autoExpandWidth = true; # *: false
        position = "left";
        width = 30; # *: 40
      };
    };

  };
}
