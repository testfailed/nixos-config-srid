# REF: <https://nix-community.github.io/nixvim/plugins/which-key/index.html>
{
  programs.nixvim = {
    plugins.which-key = {

      # Whether to enable which-key.nvim, a plugin that popup with possible
      # key bindings of the command you started typing.
      enable = true; # ==: false

      settings = {
        # hide mapping boilerplate.
        # ==: null ==: ["<silent>" ...]
        hidden = [
          "<cmd>"
          "<Cmd>"
          "<cr>"
          "<CR>"
          "<silent>"
          "^ "
          "^:"
          "^call "
          "^lua "
        ];

        # add operators that will trigger motion and text object completion
        # to enable all native operators, set the preset / operators plugin above.
        # ==: null ==: { gc = "Comments" }
        operators = {
          gc = "Comments";
        };

        # TODO: Deprecated!
        # # Manually register the description of mappings.
        # registrations = {
        #   # "<Leader>p" = "Find git files with telescope";
        #   "<Leader>b" = "[Buffer]";
        #   "<Leader>d" = "[Debug]";
        #   "<Leader>g" = "[Git]";
        #   "<Leader>gc" = "[Git Commit]";
        #   "<Leader>gt" = "[Gitsigns Toggle]";
        #   "<Leader>h" = "[Git Hunk]";
        #   "<Leader>q" = "[Session]";
        #   "<Leader>s" = "[Search]";
        #   "<Leader>w" = "[Window]";
        # };

        spec = [
          {
            __unkeyed-1 = "<Leader>b";
            group = "[Buffer]";
            icon = "󰓩 ";
          }
          {
            __unkeyed-1 = "<Leader>d";
            group = "[Debug]";
            icon = " ";
          }
          {
            __unkeyed-1 = [
              {
                __unkeyed-1 = "<Leader>g";
                group = "[Git]";
                icon = " ";
              }
              {
                __unkeyed-1 = "<Leader>gc";
                group = "[Git Commit]";
                icon = " ";
              }
              {
                __unkeyed-1 = "<Leader>gt";
                group = "[Gitsigns Toggle]";
                icon = " ";
              }
              {
                __unkeyed-1 = "<Leader>h";
                group = "[Git Hunk]";
                icon = " ";
              }
            ];
          }
          {
            __unkeyed-1 = "<Leader>q";
            group = "[Session]";
            # icon = " ";
          }
          {
            __unkeyed-1 = "<Leader>s";
            group = "[Search]";
            # icon = " ";
          }
          {
            __unkeyed-1 = "<Leader>w";
            group = "[Window]";
            # icon = " ";
            # proxy = "<C-w>";
          }
        ];
      };
    };
  };
}
