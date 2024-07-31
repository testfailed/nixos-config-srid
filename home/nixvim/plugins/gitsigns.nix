# REF: <https://nix-community.github.io/nixvim/plugins/gitsigns/index.html>
# REF: <https://github.com/lewis6991/gitsigns.nvim/>
{
  programs.nixvim = {

    keymaps = [
      #
      # Git Hunk Actions
      #

      {
        mode = "n";
        key = "]c";
        action = ":Gitsigns next_hunk<CR>";
        options = {
          silent = true;
          desc = "Next hunk";
        };
      }

      {
        mode = "n";
        key = "<Leader>n";
        action = ":Gitsigns next_hunk<CR>";
        options = {
          silent = true;
          desc = "Next hunk";
        };
      }

      {
        mode = "n";
        key = "<Leader>hn";
        action = ":Gitsigns next_hunk_inline<CR>";
        options = {
          silent = true;
          desc = "Next hunk (inline)";
        };
      }

      {
        mode = "n";
        key = "[c";
        action = ":Gitsigns prev_hunk<CR>";
        options = {
          silent = true;
          desc = "Previous hunk";
        };
      }

      {
        mode = "n";
        key = "<Leader>p";
        action = ":Gitsigns prev_hunk<CR>";
        options = {
          silent = true;
          desc = "Previous hunk";
        };
      }

      {
        mode = "n";
        key = "<Leader>hp";
        action = ":Gitsigns prev_hunk_inline<CR>";
        options = {
          silent = true;
          desc = "Previous hunk (inline)";
        };
      }

      {
        mode = [ "n" "v" ];
        key = "<Leader>hs";
        action = ":Gitsigns stage_hunk<CR>";
        options = {
          silent = true;
          desc = "Stage hunk";
        };
      }

      {
        mode = [ "n" "v" ];
        key = "<Leader>hr";
        action = ":Gitsigns reset_hunk<CR>";
        options = {
          silent = true;
          desc = "Reset hunk";
        };
      }

      {
        mode = [ "n" "v" ];
        key = "<Leader>hS";
        action = ":Gitsigns stage_buffer<CR>";
        options = {
          silent = true;
          desc = "Stage buffer";
        };
      }

      {
        mode = [ "n" "v" ];
        key = "<Leader>hR";
        action = ":Gitsigns reset_buffer<CR>";
        options = {
          silent = true;
          desc = "Reset buffer";
        };
      }

      {
        mode = [ "n" "v" ];
        key = "<Leader>hu";
        action = ":Gitsigns undo_stage_hunk<CR>";
        options = {
          silent = true;
          desc = "Undo stage hunk";
        };
      }

      {
        mode = [ "n" "v" ];
        key = "<Leader>hh";
        action = ":Gitsigns preview_hunk<CR>";
        options = {
          silent = true;
          desc = "Preview hunk";
        };
      }

      {
        mode = [ "o" "x" ];
        key = "ih";
        action = ":<C-U>Gitsigns select_hunk<CR>";
        options = {
          silent = true;
          desc = "Select hunk";
        };
      }

      #
      # Toggle Gitsigns
      #

      {
        mode = "n";
        key = "<Leader>gd";
        action = ":Gitsigns diffthis<CR>";
        options = {
          silent = true;
          desc = "Diff this";
        };
      }

      {
        mode = "n";
        key = "<Leader>gD";
        action = ":Gitsigns diffthis ~<CR>"; # TODO: check if this works
        options = {
          silent = true;
          desc = "Diff this (~) (TODO: check if this works)";
        };
      }

      {
        mode = "n";
        key = "<Leader>gtb";
        action = ":Gitsigns toggle_current_line_blame<CR>";
        options = {
          silent = true;
          desc = "Toggle current line blame";
        };
      }

      {
        mode = "n";
        key = "<Leader>gtd";
        action = ":Gitsigns toggle_deleted<CR>";
        options = {
          silent = true;
          desc = "Toggle deleted";
        };
      }

      {
        mode = "n";
        key = "<Leader>gtn";
        action = ":Gitsigns toggle_numhl<CR>";
        options = {
          silent = true;
          desc = "Toggle number highlight";
        };
      }

      {
        mode = "n";
        key = "<Leader>gtl";
        action = ":Gitsigns toggle_linehl<CR>";
        options = {
          silent = true;
          desc = "Toggle line highlight";
        };
      }

      {
        mode = "n";
        key = "<Leader>gtw";
        action = ":Gitsigns toggle_word_diff<CR>";
        options = {
          silent = true;
          desc = "Toggle word diff";
        };
      }
    ];

    plugins.gitsigns = {
      enable = true;

      settings = {
        signs = {
          add = {
            show_count = true; # ==: null ==: false
            text = "+"; # ==: null ==: "┃"
          };
          change = {
            show_count = true; # ==: null ==: false
            text = "~"; # ==: null ==: "┃"
          };
        };
      };
    };

  };
}
