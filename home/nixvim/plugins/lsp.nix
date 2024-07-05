{
  programs.nixvim = {

    plugins.lsp = {

      enable = true; # *: false

      keymaps = {
        silent = true; # *: false

        diagnostic = {
          # Navigate in diagnostics
          "<leader>j" = "goto_next";
          "<leader>k" = "goto_prev";
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
            action = "<CMD>LspStop<Enter>";
            key = "<leader>lx";
          }
          {
            action = "<CMD>LspStart<Enter>";
            key = "<leader>ls";
          }
          {
            action = "<CMD>LspRestart<Enter>";
            key = "<leader>lr";
          }
          # {
          #   action = {
          #     __raw = "require('telescope.builtin').lsp_definitions()";
          #   };
          #   key = "gd";
          # }
          # {
          #   action = "<CMD>Lspsaga hover_doc<Enter>";
          #   key = "K";
          # }
        ];
      };

      servers = {
        astro.enable = true; # *: false
        bashls.enable = true; # *: false
        clangd.enable = true; # *: false
        cmake.enable = true; # *: false
        csharp-ls.enable = true; # *: false
        cssls.enable = true; # *: false
        docker-compose-language-service.enable = true; # *: false
        dockerls.enable = true; # *: false
        emmet-ls.enable = true; # *: false
        eslint.enable = true; # *: false
        golangci-lint-ls.enable = true; # *: false
        gopls.enable = true; # *: false
        graphql.enable = true; # *: false
        hls.enable = true; # *: false
        html.enable = true; # *: false
        java-language-server.enable = true; # *: false
        jsonls.enable = true; # *: false
        kotlin-language-server.enable = true; # *: false
        lua-ls.enable = true; # *: false
        marksman.enable = true; # *: false
        nginx-language-server.enable = true; # *: false
        # nickel-ls.enable = true; # *: false # TODO: error: The option `home-manager.users.ssm.programs.nixvim.plugins.lsp.servers.nickel-ls' does not exist.
        nil-ls.enable = true; # *: false
        # nixd.enable = true; # *: false
        nushell.enable = true; # *: false
        perlpls.enable = true; # *: false
        prismals.enable = true; # *: false
        pylsp.enable = true; # *: false
        # pylyzer.enable = true; # *: false
        pyright.enable = true; # *: false
        # rnix-lsp.enable = true; # *: false
        ruby-lsp.enable = true; # *: false
        ruff.enable = true; # *: false
        # ruff-lsp.enable = true; # *: false
        rust-analyzer = {
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
        tsserver.enable = true; # *: false
        vuels.enable = true; # *: false
        yamlls.enable = true; # *: false
      };

    };

  };
}
