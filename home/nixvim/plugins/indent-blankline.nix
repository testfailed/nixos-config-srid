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

  };
}
