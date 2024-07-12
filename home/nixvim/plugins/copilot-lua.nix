{ pkgs, ... }:
{
  programs.nixvim = {
    # keymaps = [ ... ];

    plugins.copilot-lua = {
      enable = true; # ==: false

      # NOTE: Use this field to provide the path to a specific node version
      # such as one installed by nvm. Node.js version must be 16.x or newer.
      copilotNodeCommand = "${pkgs.nodejs_20}/bin/node";
    };
  };
}
