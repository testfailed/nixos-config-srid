{
  programs.nixvim = {
    # keymaps = [ ... ];

    plugins.navic = {
      enable = true; # ==: false

      # Single click to goto element, double click to open nvim-navbuddy
      # on the clicked element.
      click = true; # ==: false

      # If set to true, will add colors to icons and text as defined by
      # highlight groups NavicIcons* (NavicIconsFile, NavicIconsModule… etc.),
      # NavicText and NavicSeparator.
      highlight = true; # ==: false

      lsp = {
        # Enable to have nvim-navic automatically attach to every LSP
        # for current buffer. Its disabled by default.
        autoAttach = true; # ==: false

        preference = [
          "clangd"
          "pyright"
        ];
      };
    };
  };
}
