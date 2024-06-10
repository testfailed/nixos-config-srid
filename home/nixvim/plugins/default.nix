{
  imports = [
    # ./efm.nix
    # ./floaterm.nix
    # ./harpoon.nix
    # ./markdown-preview.nix
    # ./neorg.nix
    # ./startify.nix
    ./auto-session.nix
    ./bufferline.nix
    ./comment.nix
    ./copilot-vim.nix
    ./lsp.nix
    ./lualine.nix
    ./neo-tree.nix
    ./tagbar.nix
    ./telescope.nix
    ./treesitter.nix
    ./vimtex.nix
    ./which-key.nix
  ];

  programs.nixvim = {
    # colorschemes.base16.enable = true;
    # colorschemes.base16.colorscheme = "onedark";
    colorschemes.catppuccin.enable = true;
    colorschemes.catppuccin.settings.flavour = "macchiato";
    # colorschemes.tokyonight.enable = true;
    # colorschemes.tokyonight.settings.style = "storm";
    # colorschemes.onedark.enable = true;
    # colorschemes.vscode.enable = true;

    plugins = {

      conform-nvim.enable = true;

      gitsigns = {
        enable = true;
        settings.signs = {
          add.text = "+";
          change.text = "~";
        };
      };

      nvim-colorizer = {
        enable = true;
        userDefaultOptions.names = false;
      };

      oil.enable = true;

      trim = {
        enable = true;
        settings = {
          highlight = true;
          ft_blocklist = [
            "checkhealth"
            "floaterm"
            "lspinfo"
            "neo-tree"
            "TelescopePrompt"
          ];
        };
      };

      trouble.enable = true;

    };
  };
}
