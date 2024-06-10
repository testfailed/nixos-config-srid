{
  programs.nixvim.plugins = {
    treesitter = {
      enable = true; # *: false

      ensureInstalled = "all";
      folding = true;
      indent = true;
      nixvimInjections = true;

      incrementalSelection = {
        enable = true;
        keymaps = {
          initSelection = "gni"; # *: "gnn"
          scopeIncremental = "gnc"; # *: "grc"
          nodeIncremental = "gnn"; # *: "grn"
          nodeDecremental = "gnm"; # *: "grm"
        };
      };
    };

    treesitter-context = {
      enable = true; # *: false

      settings = {
        line_numbers = true;
        max_lines = 6; # *: 0
        min_window_height = 8; # *: 0
        mode = "topline"; # *: "cursor"
        multiline_threshold = 20;
        separator = ""; # -: ""
        trim_scope = "inner";
        zindex = 20;
      };
    };

    treesitter-refactor = {
      enable = true;
      highlightDefinitions = {
        enable = true;

        # Set to false if you have an `updatetime` of ~100.
        clearOnCursorMove = false;
      };
    };

    treesitter-textobjects = {
      enable = true;
    };

    hmts.enable = true;
  };
}
