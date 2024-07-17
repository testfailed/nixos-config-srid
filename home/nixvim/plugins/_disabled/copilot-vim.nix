{
  programs.nixvim = {

    keymaps = [
      {
        action = "<Plug>(copilot-accept-word)";
        key = "<M-;>";
        mode = [ "i" ];
        options = { noremap = true; silent = true; };
      }
      {
        action = "<Plug>(copilot-accept-line)";
        key = "<C-'>";
        mode = [ "i" ];
        options = { noremap = true; silent = true; };
      }
    ];

    plugins.copilot-vim = {
      enable = true;

      settings = {
        workspace_folders = [ "~/repos" ];
      };
    };

  };
}
