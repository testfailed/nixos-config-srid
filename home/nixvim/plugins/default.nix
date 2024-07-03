{
  imports = [
    # ./efm.nix
    # ./floaterm.nix
    # ./markdown-preview.nix
    # ./startify.nix
    ./auto-session.nix
    ./bufferline.nix
    ./comment.nix
    ./copilot-vim.nix
    ./indent-blankline.nix
    ./leap.nix
    ./lsp.nix
    ./lualine.nix
    ./marks.nix
    ./neo-tree.nix
    ./spectre.nix
    ./tagbar.nix
    ./telescope.nix
    ./treesitter.nix
    ./vimtex.nix
    ./which-key.nix
  ];

  programs.nixvim = {
    plugins = {

      # oil.enable = true; # *: false
      conform-nvim.enable = true; # *: false # TODO: move to a separate file.
      nix.enable = true; # *: false
      sleuth.enable = true; # *: false
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
