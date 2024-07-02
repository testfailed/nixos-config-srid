{
  imports = [
    # ./efm.nix
    # ./floaterm.nix
    # ./harpoon.nix
    # ./hop.nix
    # ./markdown-preview.nix
    # ./startify.nix
    ./auto-session.nix
    ./bufferline.nix
    ./comment.nix
    ./copilot-vim.nix
    ./leap.nix
    ./lsp.nix
    ./lualine.nix
    ./marks.nix
    ./neo-tree.nix
    ./tagbar.nix
    ./telescope.nix
    ./treesitter.nix
    ./vimtex.nix
    ./which-key.nix
  ];

  programs.nixvim = {
    # colorschemes.base16.colorscheme = "onedark";
    # colorschemes.base16.enable = true;
    # colorschemes.onedark.enable = true;
    colorschemes.catppuccin.enable = true;
    colorschemes.catppuccin.settings.flavour = "macchiato";

    plugins = {

      # oil.enable = true; # *: false
      conform-nvim.enable = true; # *: false # TODO: move to a separate file.
      nix.enable = true; # *: false
      trouble.enable = true; # *: false # TODO: move to a separate file.

      # TODO: move to a separate file.
      gitsigns = {
        enable = true;
        settings.signs = {
          add.text = "+";
          change.text = "~";
        };
      };

      # TODO: move to a separate file.
      nvim-colorizer = {
        enable = true;
        userDefaultOptions.names = false;
      };

      # TODO: move to a separate file.
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

    };
  };
}
