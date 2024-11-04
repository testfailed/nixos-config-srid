{
  imports = [
    # ./copilot-vim.nix # TODO: disabled due to the issue with building nodejs-18_x
    # ./noice.nix
    ./auto-session.nix
    ./bufferline.nix
    ./cmp.nix
    ./conform-nvim.nix
    ./copilot-lua.nix
    ./fugitive.nix
    ./gitsigns.nix
    ./leap.nix
    ./lsp.nix
    # ./lualine.nix
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
      trouble.enable = true; # ==: false # TODO: move to a separate file.
      vim-surround.enable = true; # ==: false

      # trace: warning: ssm profile: Nixvim: `plugins.web-devicons` was enabled automatically because the following plugins are enabled.
      # This behaviour is deprecated. Please explicitly define `plugins.web-devicons.enable` or alternatively
      #  enable `plugins.mini.enable` with `plugins.mini.modules.icons` and `plugins.mini.mockDevIcons`.
      # plugins.telescope
      # plugins.neo-tree
      # plugins.trouble
      # plugins.bufferline
      web-devicons.enable = true; # ==: false
    };
  };
}
