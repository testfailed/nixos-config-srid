# { config, lib, ... }:
# let
#   colors = import ../colors/${config.theme}.nix { };
# in
{
  programs.nixvim = {
    plugins.bufferline = {
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

    keymaps = [
      {
        mode = "n";
        key = "<Leader>/";
        action = "<Cmd>Telescope buffers<CR>";
        options = {
          desc = "Search buffers";
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
        key = "<Leader>l";
        action = "<Cmd>BufferLineCycleNext<CR>";
        options = {
          desc = "Next buffer";
        };
      }

      {
        mode = "n";
        key = "<Leader>h";
        action = "<Cmd>BufferLineCyclePrev<CR>";
        options = {
          desc = "Previous buffer";
        };
      }

      {
        mode = "n";
        key = "]b";
        action = "<Cmd>BufferLineCycleNext<CR>";
        options = {
          desc = "Next buffer";
        };
      }

      {
        mode = "n";
        key = "[b";
        action = "<Cmd>BufferLineCyclePrev<CR>";
        options = {
          desc = "Previous buffer";
        };
      }

      {
        mode = "n";
        key = "<M-l>";
        action = "<Cmd>BufferLineCycleNext<CR>";
        options = {
          desc = "Next buffer";
        };
      }

      {
        mode = "n";
        key = "<M-h>";
        action = "<Cmd>BufferLineCyclePrev<CR>";
        options = {
          desc = "Previous buffer";
        };
      }

      {
        mode = "n";
        key = "<Leader>bd";
        action = "<Cmd>bp <Bar> bd #<CR>";
        options = {
          desc = "Delete buffer";
        };
      }

      {
        mode = "n";
        key = "<Leader>bj";
        action = "<Cmd>BufferLineMoveNext<CR>";
        options = {
          desc = "Move buffer to the right";
        };
      }

      {
        mode = "n";
        key = "<Leader>bk";
        action = "<Cmd>BufferLineMovePrev<CR>";
        options = {
          desc = "Move buffer to the left";
        };
      }

      {
        mode = "n";
        key = "<Leader>bL";
        action = "<Cmd>BufferLineCloseRight<CR>";
        options = {
          desc = "Delete buffers to the right";
        };
      }

      {
        mode = "n";
        key = "<Leader>bH";
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
