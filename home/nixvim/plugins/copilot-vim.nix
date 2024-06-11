{
  programs.nixvim = {
    plugins.copilot-vim = {
      enable = true;

      settings = {
        workspace_folders = [
          "~/repos"
        ];
      };
    };

    keymaps = [
      {
        action = "<Plug>(copilot-accept-word)";
        key = "<A-'>";
        mode = [ "i" ];
        options = { noremap = true; silent = true; };
      }
      {
        action = "<Plug>(copilot-accept-line)";
        key = "<A-;>";
        mode = [ "i" ];
        options = { noremap = true; silent = true; };
      }
      {
        action = "<Plug>(copilot-accept-line)";
        key = "<C-,>";
        mode = [ "i" ];
        options = { noremap = true; silent = true; };
      }
    ];
  };
}
