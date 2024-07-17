# REF: <https://nix-community.github.io/nixvim/plugins/indent-blankline/index.html>
# REF: <https://github.com/lukas-reineke/indent-blankline.nvim/>
{
  programs.nixvim = {

    # keymaps = [];

    plugins.indent-blankline = {
      enable = true; # ==: false

      settings = {
        exclude = {
          buftypes = [
            "quickfix"
            "terminal"
          ];
          filetypes = [
            ""
            "checkhealth"
            "help"
            "lspinfo"
            "packer"
            "TelescopePrompt"
            "TelescopeResults"
            "yaml"
          ];
        };
        indent = {
          char = "│";
        };
        scope = {
          show_end = false;
          show_exact_scope = true;
          show_start = false;
        };
      }; # ==: { }
    };

    extraConfigLua = ''
      --
      -- Recipes
      --

      --
      -- Multiple indent colors
      -- REF: <https://github.com/lukas-reineke/indent-blankline.nvim/#multiple-indent-colors>
      --
      local highlight = {
          "RainbowCyan",
          "RainbowRed",
          "RainbowYellow",
          "RainbowBlue",
          "RainbowOrange",
          "RainbowGreen",
          "RainbowViolet",
      }

      local hooks = require "ibl.hooks"
      -- create the highlight groups in the highlight setup hook, so they are reset
      -- every time the colorscheme changes
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
          -- vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
          vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#FFFFFF" })
          vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
          vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
          vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
          vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
          vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
          vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
      end)

      require("ibl").setup { indent = { highlight = highlight } }

      --
      -- Background color indentation guides
      -- REF: <https://github.com/lukas-reineke/indent-blankline.nvim/#background-color-indentation-guides>
      --
      -- local highlight = {
      --     "CursorColumn",
      --     "Whitespace",
      -- }
      -- require("ibl").setup {
      --     indent = { highlight = highlight, char = "" },
      --     whitespace = {
      --         highlight = highlight,
      --         remove_blankline_trail = false,
      --     },
      --     scope = { enabled = false },
      -- }
    '';

  };
}
