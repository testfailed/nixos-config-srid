{
  imports = [
    # ./copilot-vim.nix # TODO: disabled due to the issue with building nodejs-18_x
    # ./noice.nix
    ./auto-session.nix
    ./bufferline.nix
    ./cmp.nix
    ./conform-nvim.nix
    ./copilot-lua.nix
    ./gitsigns.nix
    ./leap.nix
    ./lsp.nix
    ./lualine.nix
    ./marks.nix
    ./navic.nix
    ./neo-tree.nix
    ./nvim-colorizer.nix
    ./spectre.nix
    ./tagbar.nix
    ./telescope.nix
    ./treesitter.nix
    ./trim.nix
    ./vimtex.nix
    ./which-key.nix

    # NOTE: Order
    ./indent-blankline.nix
    ./rainbow-delimiters.nix
  ];

  programs.nixvim = {
    plugins = {
      # NOTE: One-line plugin configs
      comment.enable = true; # ==: false
      nix.enable = true; # ==: false
      sleuth.enable = true; # ==: false
      surround.enable = true; # ==: false
      trouble.enable = true; # ==: false # TODO: move to a separate file.
    };
  };
}
