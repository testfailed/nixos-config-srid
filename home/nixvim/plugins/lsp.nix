{
  programs.nixvim = {

    plugins.lsp = {

      enable = true; # *: false

      keymaps = {
        silent = true; # *: false

        diagnostic = {
          # Navigate in diagnostics
          "<Leader>dn" = "goto_next";
          "<Leader>dp" = "goto_prev";
        };

        lspBuf = {
          "<F2>" = "rename";
          gd = "definition";
          gD = "references";
          gi = "implementation";
          gt = "type_definition";
          K = "hover";
        };

        extra = [
          {
            action = "<Cmd>LspStop<CR>";
            key = "<Leader>lx";
          }
          {
            action = "<Cmd>LspStart<CR>";
            key = "<Leader>ls";
          }
          {
            action = "<Cmd>LspRestart<CR>";
            key = "<Leader>lr";
          }
          # {
          #   action = {
          #     __raw = "require('telescope.builtin').lsp_definitions()";
          #   };
          #   key = "gd";
          # }
          # {
          #   action = "<Cmd>Lspsaga hover_doc<CR>";
          #   key = "K";
          # }
        ];
      };

      servers = {
        astro.enable = true; # *: false
        bashls.enable = true; # *: false
        clangd.enable = true; # *: false
        cmake.enable = true; # *: false
        csharp_ls.enable = true; # *: false
        cssls.enable = true; # *: false
        docker_compose_language_service.enable = true; # *: false
        dockerls.enable = true; # *: false
        emmet_ls.enable = true; # *: false
        eslint.enable = true; # *: false
        golangci_lint_ls.enable = true; # *: false
        gopls.enable = true; # *: false
        graphql.enable = true; # *: false
        hls = {
          enable = true; # *: false

          installGhc = true; # ==: false # TODO: change to false.
        };
        html.enable = true; # *: false
        java_language_server.enable = true; # *: false
        jsonls.enable = true; # *: false
        kotlin_language_server.enable = true; # *: false
        lua_ls.enable = true; # *: false
        marksman.enable = true; # *: false
        nginx_language_server.enable = true; # *: false
        # nickel_ls.enable = true; # *: false # TODO: error: The option `home-manager.users.ssm.programs.nixvim.plugins.lsp.servers.nickel_ls' does not exist.
        nil_ls.enable = true; # *: false
        # nixd.enable = true; # *: false
        nushell.enable = true; # *: false
        perlpls.enable = true; # *: false
        # prismals.enable = true; # *: false # TODO: .*.package is needed
        pylsp.enable = true; # *: false
        # pylyzer.enable = true; # *: false
        pyright.enable = true; # *: false
        # rnix.enable = true; # *: false
        ruby_lsp.enable = true; # *: false
        ruff.enable = true; # *: false
        # ruff_lsp.enable = true; # *: false
        rust_analyzer = {
          enable = true; # *: false

          installCargo = true; # *: null # TODO: change to false.
          installRustc = true; # *: null # TODO: change to false.
        };
        sqls.enable = true; # *: false
        svelte.enable = true; # *: false
        tailwindcss.enable = true; # *: false
        taplo.enable = true; # *: false
        terraformls.enable = true; # *: false
        texlab.enable = true; # *: false
        ts_ls.enable = true; # *: false
        # vuels.enable = true; # *: false # TODO: .*.package is needed
        yamlls.enable = true; # *: false
      };

    };

  };
}
