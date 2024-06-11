{ config, lib, ... }:
{
  programs.nixvim = {
    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    keymaps =
      let
        normal =
          lib.mapAttrsToList
            (key: action: {
              mode = "n";
              inherit action key;
            })
            {
              "<Space>" = "<NOP>";
              "<Esc>" = ":noh<CR>";
              "<C-x>" = ":close<CR>";

              # back and fourth between the two most recent files
              "<C-c>" = ":b#<CR>";

              # manage window
              "<Leader>wd" = ":w<CR>";
              "<Leader>=" = "<C-w>=";

              # navigate window
              "<C-h>" = "<C-w>h";
              "<C-l>" = "<C-w>l";
              "<C-j>" = "<C-w>j";
              "<C-k>" = "<C-w>k";

              # Press 'H', 'L' to jump to start/end of a line (first/last character)
              H = "^";
              L = "$";

              Y = "y$";

              # resize with arrows
              "<C-Up>" = ":resize -2<CR>";
              "<C-Down>" = ":resize +2<CR>";
              "<C-Left>" = ":vertical resize +2<CR>";
              "<C-Right>" = ":vertical resize -2<CR>";

              # # move current line up/down
              # # M = Alt key
              # "<M-k>" = ":move-2<CR>";
              # "<M-j>" = ":move+<CR>";

              "<Leader>rp" = ":!remi push<CR>";

              # Bufferline
              "<A-h>" = ":BufferLineCyclePrev<CR>";
              "<A-l>" = ":BufferLineCycleNext<CR>";
              "[b" = ":BufferLineCyclePrev<CR>";
              "]b" = ":BufferLineCycleNext<CR>";
            };

        visual =
          lib.mapAttrsToList
            (key: action: {
              mode = "v";
              inherit action key;
            })
            {
              # sort lines (Asc)
              "<Leader>ss" = ":sort<CR>";
              "<Leader>si" = ":sort i<CR>";

              # sort lines (Desc)
              "<Leader>sr" = ":sort!<CR>";
              "<Leader>sri" = ":sort! i<CR>";

              # better indenting
              ">" = ">gv";
              "<" = "<gv";
              "<Tab>" = ">gv";
              "<S-Tab>" = "<gv";

              # move selected line / block of text in visual mode
              "K" = ":m '<-2<CR>gv=gv";
              "J" = ":m '>+1<CR>gv=gv";
            };

      in
      config.nixvim.helpers.keymaps.mkKeymaps
        { options.silent = true; }
        (normal ++ visual);
  };
}
