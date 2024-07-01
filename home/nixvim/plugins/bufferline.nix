{ config, lib, ... }:
let
  colors = import ../colors/${config.theme}.nix { };
in
{
  programs.nixvim = {
    plugins = {
      bufferline = {
        enable = true;
        separatorStyle = "thick"; # “slant”, “padded_slant”, “slope”, “padded_slope”, “thick”, “thin”

        # highlights = lib.mkIf config.colorschemes.base16.enable {
        #   fill = {
        #     fg = colors.base00;
        #     bg = colors.base00;
        #   };
        #   background = {
        #     fg = colors.base03;
        #     bg = colors.base01;
        #   };
        #   bufferSelected = {
        #     fg = colors.base05;
        #     bg = colors.base00;
        #     italic = false;
        #   };
        #   bufferVisible = {
        #     fg = colors.base03;
        #     bg = colors.base00;
        #   };
        #   closeButton = {
        #     fg = colors.base03;
        #     bg = colors.base01;
        #   };
        #   closeButtonVisible = {
        #     fg = colors.base03;
        #     bg = colors.base01;
        #   };
        #   closeButtonSelected = {
        #     fg = colors.base08;
        #     bg = colors.base00;
        #   };
        #
        #   indicatorSelected = {
        #     fg = colors.base00;
        #     bg = colors.base00;
        #   };
        #   indicatorVisible = {
        #     fg = colors.base00;
        #     bg = colors.base00;
        #   };
        #   separator = {
        #     fg = colors.base00;
        #     bg = colors.base00;
        #   };
        #   modified = {
        #     fg = colors.base03;
        #     bg = colors.base00;
        #   };
        #   modifiedVisible = {
        #     fg = colors.base00;
        #     bg = colors.base00;
        #   };
        #   modifiedSelected = {
        #     fg = colors.base0B;
        #     bg = colors.base00;
        #   };
        #   tabClose = {
        #     fg = colors.base00;
        #     bg = colors.base00;
        #   };
        # };

      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<Leader>bb";
        action = "<Cmd>Telescope buffers<CR>";
        options = {
          desc = "Find buffer";
        };
      }

      {
        mode = "n";
        key = "<Leader>b'";
        action = ":buffers<CR>";
        options = {
          desc = "List buffers";
        };
      }

      {
        mode = "n";
        key = "<Leader>,";
        action = "<Cmd>BufferLinePick<CR>";
        options = {
          desc = "Pick buffer";
        };
      }

      {
        mode = "n";
        key = "<Leader>.";
        action = "<Cmd>BufferLinePickClose<CR>";
        options = {
          desc = "Pick buffer to close";
        };
      }

      {
        mode = "n";
        key = "<Leader>b;";
        action = "<Cmd>e #<CR>";
        options = {
          desc = "Switch to Other Buffer";
        };
      }

      {
        mode = "n";
        key = "<Leader>bn";
        action = "<Cmd>BufferLineCycleNext<CR>";
        options = {
          desc = "Cycle to next buffer";
        };
      }

      {
        mode = "n";
        key = "<Leader>bp";
        action = "<Cmd>BufferLineCyclePrev<CR>";
        options = {
          desc = "Cycle to previous buffer";
        };
      }

      {
        mode = "n";
        key = "]b";
        action = "<Cmd>BufferLineCycleNext<CR>";
        options = {
          desc = "Cycle to next buffer";
        };
      }

      {
        mode = "n";
        key = "[b";
        action = "<Cmd>BufferLineCyclePrev<CR>";
        options = {
          desc = "Cycle to previous buffer";
        };
      }

      {
        mode = "n";
        key = "<M-l>";
        action = "<Cmd>BufferLineCycleNext<CR>";
        options = {
          desc = "Cycle to next buffer";
        };
      }

      {
        mode = "n";
        key = "<M-h>";
        action = "<Cmd>BufferLineCyclePrev<CR>";
        options = {
          desc = "Cycle to previous buffer";
        };
      }

      {
        mode = "n";
        key = "<Leader>bd";
        action = "<Cmd>bdelete<CR>";
        options = {
          desc = "Delete buffer";
        };
      }

      {
        mode = "n";
        key = "<Leader>bl";
        action = "<Cmd>BufferLineCloseRight<CR>";
        options = {
          desc = "Delete buffers to the right";
        };
      }

      {
        mode = "n";
        key = "<Leader>bh";
        action = "<Cmd>BufferLineCloseLeft<CR>";
        options = {
          desc = "Delete buffers to the left";
        };
      }

      {
        mode = "n";
        key = "<Leader>bD";
        action = "<Cmd>BufferLineCloseOthers<CR>";
        options = {
          desc = "Delete other buffers";
        };
      }

      {
        mode = "n";
        key = "<Leader>bp";
        action = "<Cmd>BufferLineTogglePin<CR>";
        options = {
          desc = "Toggle pin";
        };
      }

      {
        mode = "n";
        key = "<Leader>bP";
        action = "<Cmd>BufferLineGroupClose ungrouped<CR>";
        options = {
          desc = "Delete non-pinned buffers";
        };
      }
    ];

  };
}
