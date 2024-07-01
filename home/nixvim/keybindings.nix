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
              "<Esc>" = { action = ":noh<CR>"; desc = "Clear search highlights"; };
              "<C-x>" = { action = ":close<CR>"; desc = "Close current window"; };
              "<C-s>" = { action = ":w<CR>"; desc = "Save file"; };

              # back and fourth between the two most recent files
              "<C-c>" = { action = ":b#<CR>"; };

              # manage window
              "<Leader>wd" = { action = ":q<CR>"; desc = "Close window"; };
              "<Leader>=" = { action = "<C-w>="; desc = "Resize windows equally"; };

              # navigate window
              "<C-h>" = { action = "<C-w>h"; desc = "Move to the window on the left"; };
              "<C-l>" = { action = "<C-w>l"; desc = "Move to the window on the right"; };
              "<C-j>" = { action = "<C-w>j"; desc = "Move to the window below"; };
              "<C-k>" = { action = "<C-w>k"; desc = "Move to the window above"; };

              # Press 'H', 'L' to jump to start/end of a line (first/last character)
              "H" = { action = "^"; desc = "Jump to the start of a line"; };
              "L" = { action = "$"; desc = "Jump to the end of a line"; };

              "Y" = { action = "y$"; desc = "Yank to end of line"; };

              # resize with arrows
              "<C-Up>" = { action = ":resize -2<CR>"; desc = "Resize window up"; };
              "<C-Down>" = { action = ":resize +2<CR>"; desc = "Resize window down"; };
              "<C-Left>" = { action = ":vertical resize +2<CR>"; desc = "Resize window left"; };
              "<C-Right>" = { action = ":vertical resize -2<CR>"; desc = "Resize window right"; };

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
              "q" = { action = "@"; desc = "Execute macro"; };
              "qq" = { action = "@@"; desc = "Execute last macro"; };
              "@" = { action = "q"; desc = "Record macro"; };
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
              "<Leader>ss" = { action = ":sort<CR>"; desc = "Sort lines"; };
              "<Leader>si" = { action = ":sort i<CR>"; desc = "Sort lines (case-insensitive)"; };
              "<Leader>sn" = { action = ":sort n<CR>"; desc = "Sort lines (numeric)"; };
              "<Leader>su" = { action = ":sort u<CR>"; desc = "Sort lines (unique)"; };

              # sort lines (Desc)
              "<Leader>sr" = { action = ":sort!<CR>"; desc = "Sort lines (reverse)"; };
              "<Leader>sri" = { action = ":sort! i<CR>"; desc = "Sort lines (reverse, case-insensitive)"; };
              "<Leader>srn" = { action = ":sort! n<CR>"; desc = "Sort lines (reverse, numeric)"; };
              "<Leader>sru" = { action = ":sort! u<CR>"; desc = "Sort lines (reverse, unique)"; };

              # better indenting
              ">" = { action = ">gv"; desc = "Indent"; };
              "<" = { action = "<gv"; desc = "Unindent"; };
              "<Tab>" = { action = ">gv"; desc = "Indent"; };
              "<S-Tab>" = { action = "<gv"; desc = "Unindent"; };

              # move selected line / block of text in visual mode
              "K" = { action = ":m '<-2<CR>gv=gv"; desc = "Move selected lines up"; };
              "J" = { action = ":m '>+1<CR>gv=gv"; desc = "Move selected lines down"; };
            };

      in
      config.nixvim.helpers.keymaps.mkKeymaps
        { options.silent = true; }
        (nmap ++ nnoremap ++ vmap);
  };
}
