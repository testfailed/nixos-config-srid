{
  programs.nixvim = {

    keymaps = [
      {
        mode = "n";
        key = "<C-g>";
        action = ":TagbarToggle<cr>";
        options.silent = true;
      }
    ];

    plugins.tagbar = {
      enable = true;
      settings.width = 50;
    };

  };
}
