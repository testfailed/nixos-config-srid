# REF: <https://github.com/nvim-telescope/telescope.nvim>
{
  programs.nixvim = {
    plugins.telescope = {

      enable = true;

      keymaps = {
        "<Leader>'" = "marks";
        "<Leader>\"" = "registers";
        "<Leader>," = "jump_list";
        "<Leader>:" = "command_history";
        "<Leader>s/" = "search_history";
        "<Leader>s0" = "builtin";
        "<Leader>s?" = "current_buffer_fuzzy_find";
        "<Leader>sb" = "buffers";
        "<Leader>sc" = "commands";
        "<Leader>sd" = "diagnostics";
        "<Leader>sF" = "find_files";
        "<Leader>sf" = "git_files";
        "<Leader>sg" = "live_grep";
        "<Leader>sh" = "help_tags";
        "<Leader>sk" = "keymaps";
        "<Leader>sr" = "oldfiles";

        # FZF like bindings
        "<C-p>" = "git_files";
        "<Leader>p" = "oldfiles";
        "<C-f>" = "live_grep";
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
