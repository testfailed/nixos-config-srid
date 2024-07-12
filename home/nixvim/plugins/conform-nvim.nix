# REF: <https://nix-community.github.io/nixvim/plugins/conform-nvim/index.html>
# REF: <https://github.com/stevearc/conform.nvim>
{
  programs.nixvim = {
    plugins.conform-nvim = {
      enable = true; # ==: false

      # Map of filetype to formatters
      # TODO: set project-specific configs.
      formattersByFt = {
        # Use the "*" filetype to run formatters on all filetypes.
        "*" = [ "codespell" ];

        # Use the "_" filetype to run formatters on filetypes that don't
        # have other formatters configured.
        "_" = [ "trim_whitespace" ];

        # Use a sub-list to run only the first available formatter
        javascript = [ [ "prettierd" "prettier" ] ];

        lua = [ "stylua" ];

        nix = [ "nixpkgs_fmt" ];

        # Conform will run multiple formatters sequentially
        # python = [ "isort" "black" ];
        python = [ "ruff" ];

      }; # ==: null

      # If this is set, Conform will run the formatter asynchronously after save.
      # It will pass the table to conform.format().
      # This can also be a function that returns the table.
      formatAfterSave = {
        lspFallback = true; # ==: true # ==: "never"
      }; # ==: null

      # If this is set, Conform will run the formatter on save.
      # It will pass the table to conform.format().
      # This can also be a function that returns the table.
      # See :help conform.format for details.
      formatOnSave = {
        # Configure if and when LSP should be used for formatting.
        # Defaults to "never".
        lspFallback = true; # ==: true # ==: "never"
        timeoutMs = 500; # ==: 500 # ==: 1000
      }; # ==: null
    };
  };
}
