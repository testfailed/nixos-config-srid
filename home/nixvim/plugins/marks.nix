{
  programs.nixvim = {
    plugins.marks = {
      enable = true;

      cyclic = true;
      refreshInterval = 150;

      mappings = {
        set = "<Leader>mM";
        toggle = "<Leader>mm";
        next = "<Leader>m;";
        prev = "<Leader>m,";
        delete = "<Leader>md";
        delete_line = "<Leader>mD";
        delete_buf = "<Leader>mc";
      };
    };

    # TODO: use 'config.lib.nixvim.keymaps.mkKeymaps' instead.
    keymaps = [
      # { mode = "n"; key = "<Leader>mG"; action = "<Cmd>MarksListGlobal<CR>"; options = { desc = "List global marks"; }; }
      {
        mode = "n";
        key = "<Leader>ml";
        action = "<Cmd>MarksListAll<CR>";
        options = {
          desc = "List all marks";
        };
      }
      {
        mode = "n";
        key = "<Leader>mL";
        action = "<Cmd>MarksListBuf<CR>";
        options = {
          desc = "List marks in buffer";
        };
      }
    ];
  };
}
