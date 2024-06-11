{
  programs.nixvim = {
    plugins.marks = {
      enable = true;

      cyclic = true;
      refreshInterval = 150;
    };
  };
}
