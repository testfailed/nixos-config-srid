# REF: <https://nix-community.github.io/nixvim/plugins/telescope/index.html>
# REF: <https://github.com/nvim-telescope/telescope.nvim>
{ config, ... }:
{
  programs.nixvim = {

    # plugins.telescope = {
    #   enable = true;
    #   settings.keymaps = {
    #     "<leader>ff" = {
    #       desc = "file finder";
    #       action = "find_files";
    #     };
    #     "<leader>fg" = {
    #       desc = "find via grep";
    #       action = "live_grep";
    #     };
    #   };
    #   extensions = {
    #     file-browser.enable = true;
    #   };
    # };

    plugins.telescope = {

      enable = true;

      keymaps = {
        "<Leader>'" = "marks";
        "<Leader>\"" = "registers";
        "<Leader>," = "jump_list";
        "<Leader>;" = "command_history";
        "<Leader>s/" = "search_history";
        "<Leader>s0" = "builtin";
        "<Leader>s?" = "current_buffer_fuzzy_find";
        "<Leader>sb" = "buffers";
        "<Leader>sc" = "commands";
        "<Leader>sd" = "diagnostics";
        "<Leader>sF" = "find_files";
        "<Leader>sg" = "live_grep";
        "<Leader>sh" = "help_tags";
        "<Leader>sk" = "keymaps";
        "<Leader>sr" = "oldfiles";

        # Git related
        "<Leader>g," = "git_stash";
        "<Leader>gb" = "git_branches";
        "<Leader>gcb" = "git_bcommits";
        "<Leader>gcc" = "git_commits";
        "<Leader>gcr" = "git_bcommits_range";
        "<Leader>gg" = "git_files";
        "<Leader>gs" = "git_status";

        # Frecency Algorithm
        # "<Leader>sf" = "frecency";
        # "<Leader>sf" = "frecency path_display={\"shorten\"} theme=ivy";
        # "<Leader>f" = "frecency workspace=CWD path_display={\"shorten\"} theme=ivy";
        "<Leader>sf" = "frecency";
        "<Leader>f" = "frecency workspace=CWD";

        # FZF like bindings
        "<C-p>" = "git_files";
        "<Leader>p" = "oldfiles";
        "<C-f>" = "live_grep";
      };

      extensions = {
        file-browser = {
          enable = false; # ==: false

          settings = {
            file_browser = {
              hijack_netrw = true;
              theme = "ivy";
            };
          }; # ==: { }
        };

        frecency = {
          enable = true; # ==: false

          settings = {
            auto_validate = true; # ==: null # ==: true
            # db_root = "${config.xdg.dataHome}/nvim/telescope_frecency/db";
            db_root = { __raw = "vim.fn.stdpath 'data'"; }; # ==: { __raw = ... }
            disable_devicons = false;
            ignore_patterns = [ "*.git/*" "*/tmp/*" ];
            show_scores = false;
            show_unindexed = true;
            workspaces = {
              home = "${config.home.homeDirectory}}";
              conf = "${config.home.homeDirectory}/.config";
              data = "${config.home.homeDirectory}/.local/share";

              doc = "${config.home.homeDirectory}/Documents";
              down = "${config.home.homeDirectory}/Downloads";

              repos = "${config.home.homeDirectory}/repos";
            };
          };
        };
      };

      settings.defaults = {
        file_ignore_patterns = [
          "^.git/"
          "^.mypy_cache/"
          "^__pycache__/"
          "^data/"
          "^output/"

          "%.ipynb"
        ];

        set_env.COLORTERM = "truecolor";
      };

    };
  };
}
