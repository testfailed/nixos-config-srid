# { inputs, pkgs, ... }:
# { self, inputs, config, options, pkgs, lib, flake, specialArgs }:
# { self, inputs, config, options, pkgs, lib, flake, specialArgs, modulesPath, ... }:
{ pkgs, ... }:
{
  imports = [
    # inputs.nixvim.homeManagerModules.nixvim

    ./colors
    ./plugins

    # ./todo.nix
    ./autocommands.nix
    ./completion.nix
    ./keybindings.nix
    ./options.nix
  ];

  programs.nixvim = {
    enable = pkgs.stdenv.isDarwin; # nixvim uses IFD; so not using it on Linux (breaks colmena apply)

    #   plugins = {
    #
    #     # UI
    #     lualine.enable = true;
    #     bufferline.enable = true;
    #     treesitter.enable = true;
    #     which-key = {
    #       enable = true;
    #     };
    #     noice = {
    #       # WARNING: This is considered experimental feature, but provides nice UX
    #       enable = true;
    #       presets = {
    #         bottom_search = true;
    #         command_palette = true;
    #         long_message_to_split = true;
    #         #inc_rename = false;
    #         #lsp_doc_border = false;
    #       };
    #     };
    #     telescope = {
    #       enable = true;
    #       settings.keymaps = {
    #         "<leader>ff" = {
    #           desc = "Find files";
    #           action = "find_files";
    #         };
    #         "<leader>sg" = {
    #           desc = "Find via grep";
    #           action = "live_grep";
    #         };
    #       };
    #       extensions = {
    #         file-browser.enable = true;
    #       };
    #     };
    #
    #     # Dev
    #     lsp = {
    #       enable = true;
    #       servers = {
    #         hls.enable = true;
    #         marksman.enable = true;
    #         nil-ls.enable = true;
    #         rust-analyzer = {
    #           enable = true;
    #           installCargo = false;
    #           installRustc = false;
    #         };
    #       };
    #     };
    #   };
  };
}
