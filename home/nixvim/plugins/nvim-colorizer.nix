{
  programs.nixvim = {
    # keymaps = [ ... ];

    plugins.nvim-colorizer = {
      enable = true;
      userDefaultOptions.names = false;
    };
  };
}
