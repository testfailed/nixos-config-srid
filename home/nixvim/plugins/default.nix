{
  imports = [
    ./cmp.nix
    ./lsp.nix
    ./telescope.nix
    ./treesitter.nix

    ./auto-session.nix
    ./bufferline.nix
    ./comment.nix
    ./conform-nvim.nix
    ./copilot-lua.nix
    # ./copilot-vim.nix # TODO: disabled due to the issue with building nodejs-18_x
    ./gitsigns.nix
    ./indent-blankline.nix
    ./leap.nix
    ./lualine.nix
    ./marks.nix
    ./navic.nix
    ./neo-tree.nix
    # ./noice.nix
    ./nvim-colorizer.nix
    ./spectre.nix
    ./tagbar.nix
    ./trim.nix
    ./vimtex.nix
    ./which-key.nix
  ];

  programs.nixvim = {
    plugins = {
      # One-line plugin configs
      nix.enable = true; # ==: false
      sleuth.enable = true; # ==: false
      surround.enable = true; # ==: false
      trouble.enable = true; # ==: false # TODO: move to a separate file.
    };
  };
}
