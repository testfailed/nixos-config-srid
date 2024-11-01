{ config, lib, ... }:

{
  programs.nixvim = {

    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    keymaps =
      let

        #
        # Normal Mode
        #
        nmap =
          lib.mapAttrsToList
            # (key: action: {
            (key: { action, desc ? "<undefined>" }: {
              mode = "n";
              inherit action key;
              options = {
                inherit desc;
                noremap = false;
              };
            })
            {
              "<Space>" = { action = "<NOP>"; };
              "<Esc>" = { action = "<Cmd>noh<CR>"; desc = "Clear search highlights"; };
              "<C-x>" = { action = "<Cmd>close<CR>"; desc = "Close current window"; };
              "<C-s>" = { action = "<Cmd>w<CR>"; desc = "Save file"; };

              # manage window
              "<Leader>=" = { action = "<C-w>="; desc = "Resize windows equally"; };
              "<Leader>wd" = { action = "<Cmd>q<CR>"; desc = "Close window"; };
              "<Leader>ws" = { action = "<Cmd>split<CR>"; desc = "Split window"; };
              "<Leader>wv" = { action = "<Cmd>vsplit<CR>"; desc = "Vsplit window"; };

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
              # "<C-Up>" = { action = "<Cmd>resize -2<CR>"; desc = "Resize window up"; };
              # "<C-Down>" = { action = "<Cmd>resize +2<CR>"; desc = "Resize window down"; };
              # "<C-Left>" = { action = "<Cmd>vertical resize +2<CR>"; desc = "Resize window left"; };
              # "<C-Right>" = { action = "<Cmd>vertical resize -2<CR>"; desc = "Resize window right"; };
              "<C-Up>" = { action = "<Cmd>resize +2<CR>"; desc = "Resize window up"; };
              "<C-Down>" = { action = "<Cmd>resize -2<CR>"; desc = "Resize window down"; };
              "<C-Left>" = { action = "<Cmd>vertical resize -2<CR>"; desc = "Resize window left"; };
              "<C-Right>" = { action = "<Cmd>vertical resize +2<CR>"; desc = "Resize window right"; };

              # Buffer
              "<Leader>b'" = { action = "<Cmd>buffers<CR>"; desc = "List buffers"; };
              # "<Leader>b," = { action = ":ls<CR>:b<Space>"; desc = "List buffers and jump to"; };
              "<Leader>b," = { action = ":set nomore <Bar> :ls <Bar> :set more <CR>:b<Space>"; desc = "List buffers and jump to"; };
              "<M-w>" = { action = "<Cmd>b#<CR>"; desc = "Switch to Other Buffer"; }; # TODO: not working.
              "<Leader>bn" = { action = "<Cmd>bn<CR>"; desc = "Next buffer"; };
              "<Leader>bp" = { action = "<Cmd>bp<CR>"; desc = "Previous buffer"; };
            };

        #
        # Normal Mode (noremap)
        #
        nnoremap =
          lib.mapAttrsToList
            (key: { action, desc ? "<undefined>" }: {
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
              "q;" = { action = "@:"; desc = "Execute last command-line command"; };
              "@" = { action = "q"; desc = "Record macro"; };
            };

        #
        # Visual Mode
        #
        vmap =
          lib.mapAttrsToList
            # (key: action: {
            (key: { action, desc ? "<undefined>" }: {
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
        # lib.nixvim.lib.nixvim.keymaps.mkKeymaps
        { options.silent = true; }
        (nmap ++ nnoremap ++ vmap);
  };
}
