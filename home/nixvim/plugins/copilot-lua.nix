{ pkgs, ... }:
{
  programs.nixvim = {
    # keymaps = [ ... ];

    plugins.copilot-lua = {
      enable = true; # ==: false

      # NOTE: Use this field to provide the path to a specific node version
      # such as one installed by nvm. Node.js version must be 16.x or newer.
      copilotNodeCommand = "${pkgs.nodejs_20}/bin/node";
      filetypes = {
        # NOTE: Default settings
        "." = false;
        cvs = false;
        gitcommit = true; # ==: false
        gitrebase = false;
        help = false;
        hgcommit = false;
        json = true; # ==: ?
        markdown = true; # ==: false
        svn = false;
        toml = true; # ==: ?
        yaml = true; # ==: false

        nix = true;
        terraform = true;
        sh.__raw = ''
          function ()
            if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), '^%.env.*') then
              -- disable for .env files
              return false
            end
            return true
          end
        '';

        javascript = true;
        python = true;
        typescript = true;

        # disable for all other filetypes and ignore default `filetypes`.
        "*" = false;
      };

      panel = {
        enabled = true; # ==: null # ==: true

        autoRefresh = true; # ==: null # ==: false

        keymap = {
          accept = "<M-;>"; # ==: null # ==: "<CR>"
          jumpNext = "<M-]>"; # ==: null # ==: "]]"
          jumpPrev = "<M-[>"; # ==: null # ==: "[["
          open = "<M-S-i>"; # ==: null # ==: "<M-CR>"
          refresh = "gr"; # ==: null # ==: "gr"
        };

        # layout = { };
      };

      suggestion = {
        enabled = true; # ==: null # ==: true

        autoTrigger = true; # ==: null # ==: false

        keymap = {
          accept = "<M-'>"; # ==: null # ==: "<M-l>"
          acceptLine = "<M-S-;>"; # ==: null # ==: false
          acceptWord = "<M-;>"; # ==: null # ==: false
          dismiss = "<C-]>"; # ==: null # ==: "<C-]>"
          next = "<M-]>"; # ==: null # ==: "<M-]>"
          prev = "<M-[>"; # ==: null # ==: "<M-[>"
        };
      };
    };
  };
}
