{
  programs.nixvim = {
    # keymaps = [ ... ];

    plugins.navic = {
      enable = true; # ==: false

      settings = {
        # Single click to goto element, double click to open nvim-navbuddy
        # on the clicked element.
        click = true; # ==: false

        depth_limit = null;
        depth_limit_indicator = null;

        # If set to true, will add colors to icons and text as defined by
        # highlight groups NavicIcons* (NavicIconsFile, NavicIconsModule… etc.),
        # NavicText and NavicSeparator.
        highlight = true; # ==: false

        lazy_update_context = null;
        safe_output = null;
        separator = null;

        lsp = {
          # Enable to have nvim-navic automatically attach to every LSP
          # for current buffer. Its disabled by default.
          autoAttach = true; # ==: false

          preference = [
            "clangd"
            "pyright"
            "tsserver"
          ];
        };
      };
    };
  };
}
