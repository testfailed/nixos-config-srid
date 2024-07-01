{ config, lib, ... }:
{
  programs.nixvim = {
    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    keymaps =
      let
        nmap =
          lib.mapAttrsToList
            # (key: action: {
            (key: { action, desc ? "" }: {
              mode = "n";
              inherit action key;
              options = {
                inherit desc;
                noremap = false;
              };
            })
            {
              "<Space>" = { action = "<NOP>"; };
              "<Esc>" = { action = ":noh<CR>"; };
              "<C-x>" = { action = ":close<CR>"; };
              "<C-s>" = { action = ":w<CR>"; };

              # back and fourth between the two most recent files
              "<C-c>" = { action = ":b#<CR>"; };

              # manage window
              "<Leader>wd" = { action = ":q<CR>"; };
              "<Leader>=" = { action = "<C-w>="; };

              # navigate window
              "<C-h>" = { action = "<C-w>h"; };
              "<C-l>" = { action = "<C-w>l"; };
              "<C-j>" = { action = "<C-w>j"; };
              "<C-k>" = { action = "<C-w>k"; };

              # Press 'H', 'L' to jump to start/end of a line (first/last character)
              "H" = { action = "^"; };
              "L" = { action = "$"; };

              "Y" = { action = "y$"; };

              # resize with arrows
              "<C-Up>" = { action = ":resize -2<CR>"; };
              "<C-Down>" = { action = ":resize +2<CR>"; };
              "<C-Left>" = { action = ":vertical resize +2<CR>"; };
              "<C-Right>" = { action = ":vertical resize -2<CR>"; };

              # # move current line up/down
              # # M = Alt key
              # "<M-k>" = { action = ":move-2<CR>"; };
              # "<M-j>" = { action = ":move+<CR>"; };

              "<Leader>rp" = { action = ":!remi push<CR>"; };
            };

        nnoremap =
          lib.mapAttrsToList
            (key: { action, desc ? "" }: {
              mode = "n";
              inherit action key;
              options = {
                inherit desc;
                noremap = true;
              };
            })
            {
              "q" = {
                action = "@";
                desc = "Execute macro";
              };
              "qq" = {
                action = "@@";
                desc = "Execute last macro";
              };
              "@" = {
                action = "q";
                desc = "Record macro";
              };
            };

        vmap =
          lib.mapAttrsToList
            # (key: action: {
            (key: { action, desc ? "" }: {
              mode = "v";
              inherit action key;
              options = {
                inherit desc;
                noremap = false;
              };
            })
            {
              # sort lines (Asc)
              "<Leader>ss" = { action = ":sort<CR>"; };
              "<Leader>si" = { action = ":sort i<CR>"; };
              "<Leader>sn" = { action = ":sort n<CR>"; };
              "<Leader>su" = { action = ":sort u<CR>"; };

              # sort lines (Desc)
              "<Leader>sr" = { action = ":sort!<CR>"; };
              "<Leader>sri" = { action = ":sort! i<CR>"; };
              "<Leader>srn" = { action = ":sort! n<CR>"; };
              "<Leader>sru" = { action = ":sort! u<CR>"; };

              # better indenting
              ">" = { action = ">gv"; };
              "<" = { action = "<gv"; };
              "<Tab>" = { action = ">gv"; };
              "<S-Tab>" = { action = "<gv"; };

              # move selected line / block of text in visual mode
              "K" = { action = ":m '<-2<CR>gv=gv"; };
              "J" = { action = ":m '>+1<CR>gv=gv"; };
            };

      in
      config.nixvim.helpers.keymaps.mkKeymaps
        { options.silent = true; }
        (nmap ++ nnoremap ++ vmap);
  };
}
