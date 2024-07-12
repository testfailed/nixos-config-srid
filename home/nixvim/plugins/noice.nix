{
  programs.nixvim = {
    noice = {
      # WARNING: This is considered experimental feature, but provides nice UX
      enable = true;
      presets = {
        bottom_search = true;
        command_palette = true;
        long_message_to_split = true;
        # inc_rename = false;
        # lsp_doc_border = false;
      };
    };
  };
}
