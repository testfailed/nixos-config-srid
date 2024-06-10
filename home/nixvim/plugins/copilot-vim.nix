{
  programs.nixvim = {
    plugins.copilot-vim = {
      enable = true;

      settings = {
        workspace_folders = [
          "~/repos"
        ];
      };
    };
  };
}
