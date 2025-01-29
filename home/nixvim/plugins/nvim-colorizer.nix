{
  programs.nixvim = {
    # keymaps = [ ... ];

    plugins.colorizer = {
      enable = true;

      settings = {
        user_default_options.names = false;
      };
    };
  };
}
