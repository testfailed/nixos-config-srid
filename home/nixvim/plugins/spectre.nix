{
  programs.nixvim = {
    # keymaps = [];

    plugins.spectre = {
      enable = true; # *: false

      settings = {
        default = {
          find = {
            cmd = "rg";
            options = [
              "word"
              "hidden"
            ];
          };
          replace = {
            cmd = "sed";
          };
        };
        find_engine = {
          rg = {
            args = [
              "--color=never"
              "--no-heading"
              "--with-filename"
              "--line-number"
              "--column"
            ];
            cmd = "rg";
            options = {
              hidden = {
                desc = "hidden file";
                icon = "[H]";
                value = "--hidden";
              };
              ignore-case = {
                desc = "ignore case";
                icon = "[I]";
                value = "--ignore-case";
              };
              line = {
                desc = "match in line";
                icon = "[L]";
                value = "-x";
              };
              word = {
                desc = "match in word";
                icon = "[W]";
                value = "-w";
              };
            };
          };
        };
        is_insert_mode = false;
        live_update = true;
      };
    };
  };
}
