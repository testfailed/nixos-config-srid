{
  programs.nixvim = {
    opts.completeopt = [ "menu" "menuone" "noselect" ];

    plugins = {
      luasnip.enable = true;

      lspkind = {
        enable = true;

        cmp = {
          enable = true;
          menu = {
            copilot = "";
            nvim_lsp = "[LSP]";
            nvim_lua = "[api]";
            path = "[path]";
            luasnip = "[snip]";
            buffer = "[buffer]";
            neorg = "[neorg]";
            cmp_tabby = "[Tabby]";
          };
        };
      };

      # Github Copilot Completion
      copilot-cmp = {
        enable = true; # ==: false

        event = [
          "InsertEnter"
          "LspAttach"
        ];
      };

      # cuda
      # cmp-tabby.host = "http://10.10.10.5:8080";
      cmp-tabby.settings.host = "http://10.10.10.5:8080";

      cmp = {
        enable = true; # ==: false

        autoEnableSources = true; # ==: true

        settings = {
          snippet.expand = "function(args) require('luasnip').lsp_expand(args.body) end";

          mapping = {
            "<C-d>" = "cmp.mapping.scroll_docs(-4)";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-e>" = "cmp.mapping.close()";
            "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
            "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<C-;>" = "cmp.mapping.confirm({ select = true })";
            "<M-i>" = "cmp.mapping.confirm({ select = true })";
          };

          sources = [
            { name = "path"; group_index = 1; }
            { name = "copilot"; group_index = 1; }

            { name = "nvim_lsp"; group_index = 2; }
            { name = "cmp_tabby"; group_index = 2; }
            { name = "luasnip"; group_index = 2; }
            {
              name = "buffer";
              # Words from other open buffers can also be suggested.
              option.get_bufnrs.__raw = "vim.api.nvim_list_bufs";
              group_index = 3;
            }
            { name = "neorg"; group_index = 3; }
          ];
        };
      };
    };
  };
}
