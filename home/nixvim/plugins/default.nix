{
  imports = [
    # ./barbar.nix
    # ./comment.nix
    # ./efm.nix
    # ./floaterm.nix
    # ./harpoon.nix
    # ./markdown-preview.nix
    # ./neorg.nix
    # ./startify.nix
    ./auto-session.nix
    # ./bufferline.nix
    ./lsp.nix
    ./lualine.nix
    ./neo-tree.nix
    ./tagbar.nix
    ./telescope.nix
    ./treesitter.nix
    ./vimtex.nix
  ];

  programs.nixvim = {
    # colorschemes.gruvbox.enable = true;
    colorschemes.tokyonight.enable = true;

    plugins = {
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
    };
  };
}
