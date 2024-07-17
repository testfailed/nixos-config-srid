{
  programs.nixvim = {

    keymaps = [
      {
        mode = "n";
        key = "<Leader>e";
        # action = ":Neotree action=focus reveal toggle<CR>";
        action = ":Neotree action=focus reveal toggle<CR><C-w>=";
        # action = "<Cmd>Neotree action=focus reveal toggle<CR><C-w>=";
        options.silent = false;
      }

      {
        mode = "n";
        key = "<M-e>";
        action = ":Neotree action=focus reveal<CR><C-w>=";
        # action = "<Cmd>Neotree action=focus reveal<CR><C-w>=";
        options.silent = false;
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
