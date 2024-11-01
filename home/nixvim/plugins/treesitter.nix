{
  programs.nixvim.plugins = {

    # REF: <https://nix-community.github.io/nixvim/plugins/treesitter/index.html>
    treesitter = {
      enable = true; # ==: false

      # TODO: Check if these options are still valid.
      # folding = true; # ==: false
      # languageRegister = {
      #   cpp = "onelab";
      #   python = [
      #     "myFiletype"
      #     "anotherFiletype"
      #   ];
      # }; # ==: { }
      # nixGrammars = true; # ==: true

      # Whether to enable nixvim specific injections,
      # like lua highlighting in extraConfigLua.
      nixvimInjections = true; # ==: false

      settings = {
        auto_install = false;
        ensureInstalled = "all"; # ==: "all"
        sync_install = false;

        highlight = {
          additional_vim_regex_highlighting = true;
          custom_captures = { };
          disable = [
            # "rust"
          ];
          enable = true;
        };

        ignore_install = [
          "rust"
        ];

        incremental_selection = {
          enable = true; # ==: false

          keymaps = {
            init_selection = "gni";
            node_decremental = "grm";
            node_incremental = "grn";
            scope_incremental = "grc";
          };
        };

        indent = {
          enable = true;
        };

        parser_install_dir = {
          __raw = "vim.fs.joinpath(vim.fn.stdpath('data'), 'treesitter')";
        };
      };
    };

    # REF: <https://nix-community.github.io/nixvim/plugins/treesitter-context/index.html>
    # REF: <https://github.com/nvim-treesitter/nvim-treesitter-context/>
    treesitter-context = {
      enable = true; # ==: false

      settings = {
        line_numbers = true;
        max_lines = 6; # ==: 0
        min_window_height = 8; # ==: 0
        mode = "topline"; # ==: "cursor"
        multiline_threshold = 20;
        separator = null;
        trim_scope = "inner";
        zindex = 20;
      };
    };

    # REF: <https://nix-community.github.io/nixvim/plugins/treesitter-refactor/index.html>
    treesitter-refactor = {
      # Whether to enable treesitter-refactor.
      # (requires plugins.treesitter.enable to be true)
      enable = true; # ==: false

      highlightCurrentScope = {
        # Whether to enable highlighting the block from the current scope
        # where the cursor is.
        enable = true; # ==: false

        disable = [ ]; # ==: [ ]
      };

      highlightDefinitions = {
        # Whether to enable Highlights definition and usages
        # of the current symbol under the cursor.
        enable = true; # ==: false

        # Set to false if you have an `updatetime` of ~100.
        clearOnCursorMove = false; # ==: true
        disable = [ ]; # ==: [ ]
      };

      navigation = {
        # Whether to enable Provides “go to definition” for the symbol
        # under the cursor, and lists the definitions from the current file.
        enable = true; # ==: false

        disable = [ ]; # ==: [ ]

        keymaps = {
          gotoDefinition = "gnd"; # ==: "gnd"
          gotoNextUsage = "<M-*>"; # ==: "<M-*>"
          gotoPreviousUsage = "<M-#>"; # ==: "<M-#>"
          listDefinitions = "gnD"; # ==: "gnD"
          listDefinitionsToc = "gO"; # ==: "gO"
        };
      };

      smartRename = {
        # Whether to enable Renames the symbol under the cursor
        # within the current scope (and current file).
        enable = true; # ==: false

        disable = [ ]; # ==: [ ]

        keymaps = {
          # Rename symbol under the cursor.
          smartRename = "grr"; # ==: "grr"
        };
      };
    };

    # REF: <https://nix-community.github.io/nixvim/plugins/treesitter-textobjects/index.html>
    treesitter-textobjects = {
      # Whether to enable treesitter-textobjects.
      # (requires plugins.treesitter.enable to be true)
      enable = true; # ==: false

      extraOptions = { }; # ==: { }

      lspInterop = {
        # LSP interop.
        enable = true; # ==: null ==: false
      };

      move = {
        # Go to next/previous text object~
        #
        # Define your own mappings to jump to the next or previous text object.
        # This is similar to |]m|, |[m|, |]M|, |[M|
        # Neovim’s mappings to jump to the next or previous function.
        enable = true; # ==: null ==: false

        # Whether to set jumps in the jumplist.
        setJumps = true; # ==: null ==: true
      };

      select = {
        # Text object selection:
        #
        # Define your own text objects mappings similar to
        # ip (inner paragraph) and ap (a paragraph).
        enable = true; # ==: null ==: false

        disable = [ ]; # ==: [ ]

        # when true textobjects are extended to include
        # preceding or succeeding whitespace.
        includeSurroundingWhitespace = false; # ==: null ==: false
      };

      swap = {
        # Swap text objects:
        #
        # Define your own mappings to swap the node under the cursor
        # with the next or previous one, like function parameters or arguments.
        enable = true; # ==: null ==: false

        disable = [ ]; # ==: [ ]
      };
    };

    # Whether to enable hmts.nvim.
    hmts.enable = true; # ==: false
  };
}
